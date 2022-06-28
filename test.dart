import 'dart:html';

main() {
  var title = Element.html("<h2>PackList</h2>");
  document.body!.children.add(title);
  var itemInput = Element.tag("input") as InputElement;
  itemInput.id = "txt-item";
  itemInput.placeholder = "Enter an item";
  itemInput.onKeyPress.listen((KeyboardEvent event) {
    if (event.keyCode == 13) {
      // Enter key
      addItem();
    }
  });
  document.body!.children.add(itemInput);

  ButtonElement addButton = Element.tag("button") as ButtonElement;
  addButton.id = "btn-add";
  addButton.text = "Add";
  addButton.onClick.listen((event) => addItem());
  document.body!.children.add(addButton);

  DivElement itemContainer = Element.tag("div") as DivElement;
  itemContainer.id = "items";
  itemContainer.style.width = "300px";
  itemContainer.style.border = "1px solid black";
  itemContainer.innerHtml = "&nbsp;";
  document.body!.children.add(itemContainer);
}

addItem() {
  var itemInputList = querySelectorAll("input");
  InputElement itemInput = itemInputList[0] as InputElement;
  DivElement itemContainer = querySelector("#items") as DivElement;
  var packItem = PackItem(itemInput.value);
  itemContainer.children.add(packItem.uiElement);
  itemInput.value = "";
}

class PackItem {
  var itemText;
  var _uiElement;
  var _isPacked = false;

  PackItem(this.itemText) {}

  bool get isPacked => _isPacked;

  set isPacked(value) {
    _isPacked = value;
    if (_isPacked == true) {
      uiElement.classes.add("packed");
    } else {
      uiElement.classes.remove("packed");
    }
  }

  DivElement get uiElement {
    if (_uiElement == null) {
      _uiElement = Element.tag("div");
      _uiElement.classes.add("item");
      _uiElement.text = itemText;
      _uiElement.onClick.listen((event) => isPacked = !isPacked);
    }
    return _uiElement;
  }
}
