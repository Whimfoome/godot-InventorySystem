# Dynamic Inventory System ![Godot 3.2](https://img.shields.io/badge/godot-v3.2-%23478cbf)
![Screenshot of Dynamic Inventory System](https://i.imgur.com/VTYxkpd.png)

This is easily modifiable Inventory System ready for use. If you need anything further, you can add it. I tried to make the code easy to read.
If you have any questions, check the [Wiki](https://github.com/Whimfoome/godot-InventorySystem/wiki). Can't find answer? Feel free to [open an issue](https://github.com/Whimfoome/godot-InventorySystem/issues)!

### How it works:
- Inventory Component - you add this node to any other node and now it has Inventory. (example: Player, Container). The functions and the data is stored in the component.
- The Slots are just UI with Item Structure and Amount. For example a slot can contain the information of Apple Item and how much amount it has. It takes this information from the Inventory Component.
- Inventory Window just makes an array of Slots.
- Every Item is a different class and that makes the system dynamic. You can make every item to make whatever function you want and is very easy to use.

### Information:
- Written in GDScript
- The system can be extended to almost every type of game that uses Inventory (RPG, Survival, Action-Adventure, etc.)
- To open the Player Inventory, press `Space` or `Enter`. Other things are made as buttons, but you can implement them in your game in whatever form you want.
- Use Items with `Right Mouse Button`
- Inventory Query with `Esc`
- Supports Slot Drag and Drop by holding `Left Mouse Button` and Tooltips by hovering the mouse over a slot

### Credits:
- Based on [Ryan Laley's Inventory System Tutorial Series](https://www.youtube.com/watch?v=yxqSkFNAzE0&list=PL4G2bSPE_8uktjEdP4ZuRq5r2o4JMdZfM)
- Item Images from [Kenney's Assets](https://www.kenney.nl/assets/voxel-pack)
