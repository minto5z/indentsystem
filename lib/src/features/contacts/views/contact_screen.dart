import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indentsystem/src/features/auth/logic/repository/auth_repository.dart';
import 'package:indentsystem/src/features/contacts/logic/provider/contact_api_provider.dart';
import 'package:indentsystem/src/features/contacts/views/contact_search_input_sliver.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../shared/views/widgets/global_widget.dart';
import '../logic/models/contact_response.dart';
import 'contact_list_item.dart';

class ContactScreen extends StatefulWidget {
  static const routeName = '/contact';

  static route() => MaterialPageRoute(builder: (_) => const ContactScreen());

  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  static const _pageSize = 10;

  final PagingController<int, Data> _pagingController =
      PagingController(firstPageKey: 0);

  String? _searchTerm;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    super.initState();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final repository = context.read<AuthRepository>();
      final accessToken = await repository.getAccessToken();
      final newItems = await ContactAPIProvider.getCharacterList(
        pageKey,
        _pageSize,
        searchTerm: _searchTerm,
        accessToken: accessToken,
      );

      final isLastPage = (newItems.data?.length != null)
          ? newItems.data?.length
          : 0 < _pageSize;
      if (isLastPage != null) {
        _pagingController.appendLastPage(newItems.data!);
      } else {
        final nextPageKey = pageKey + newItems.data?.length;
        _pagingController.appendPage(newItems.data!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _globalWidget.globalAppBar(context),
      drawer: _globalWidget.globalDrawer(context),
      body: CustomScrollView(
        slivers: <Widget>[
          ContactSearchInputSliver(
            onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
          ),
          PagedSliverList<int, Data>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Data>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => ContactListItem(
                contact: item,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }
}
