class ListItem {
  int value;
  String name;


  ListItem(this.value, this.name,);
   Map<String, dynamic> toMap() => {'name': name, 'value': value};
}