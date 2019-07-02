import 'package:events/views/category.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: Category.categoryList
              .map<Widget>((v) => CategoryItem(category: v))
              .toList(),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(category.icon)),
      title: Text(category.name),
      trailing: category.name.length % 2 == 0
          ? Icon(FontAwesomeIcons.checkCircle)
          : null,
      onTap: () {},
    );
  }

  final Category category;
}
