import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myshop_admin/Model/category_model.dart';
import 'package:myshop_admin/provider/category_provider.dart';
import 'package:myshop_admin/screens/edit_category_screen.dart';
import 'package:myshop_admin/utils/utils.dart';
import 'package:myshop_admin/widgets/constants.dart';

import 'package:provider/provider.dart';

class CategoryListview extends StatelessWidget {
  final List<CategoryModel> cat;

  const CategoryListview({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final categoryprovider = Provider.of<CategoryProvider>(context);
    return ListView.builder(
      itemCount: cat.length,
      itemBuilder: (context, index) {
        final category = cat[index];
        return InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.purple),
                        onPressed: () async {
                          await categoryprovider
                              .deleteCategory(category.categoryId);
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            Utils.navigateTo(context,
                                EditCategoryScreen(category: category));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: PrimaryColor,
                          )),
                    ],
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: category.categoryImageurl.toString(),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: Text(
                    category.categoryName,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
