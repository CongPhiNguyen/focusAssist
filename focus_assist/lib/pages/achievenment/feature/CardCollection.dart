
import 'package:flutter/material.dart';

import 'package:focus_assist/classes/ClassCardShop.dart';
import 'package:focus_assist/classes/ClassPokemon.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class DetailCardCollection extends StatefulWidget {
  final Size size;

  const DetailCardCollection({Key key, this.size}) : super(key: key);

  @override
  _DetailCardCollectionState createState() => _DetailCardCollectionState(size);
}

class _DetailCardCollectionState extends State<DetailCardCollection> {
  final Size size;

  _DetailCardCollectionState(this.size);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      padding: EdgeInsets.all(5),
      children: List.generate(StaticData.EggUser.length, (index) {
        return Center(
          child: Container(
            margin: EdgeInsets.only(top:3,bottom: 3,left: 6,right: 6),
            width: size.width*0.4,
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    // child: Image.asset(value[index].imageEgg),
                    child: Image.asset(StaticData.EggUser[index].imageEgg),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      StaticData.EggUser[index].TenVP,
                      style: TextStyle(color: StaticData.EggUser[index].rareColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.search,size: 20 ,),
                    padding: EdgeInsets.only(bottom: 20),
                    onPressed:(){
                      _show(
                        context,
                        StaticData.EggUser[index].MaVP,
                        StaticData.EggUser[index].TenVP,
                        StaticData.EggUser[index].rareColor,
                        StaticData.EggUser[index].Gia,
                        StaticData.EggUser[index].imageEgg,
                        StaticData.EggUser[index].moTa,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  void _show(context, String mavp,String name, Color rareColor,int price, String imageEgg, String mota){
    Alert(
      context: context,
      title: 'Information',
      closeIcon: Icon(Icons.info_outlined),
      desc: 'Đã sở hữu',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(name,style: TextStyle(color: rareColor),),
          Image.asset(imageEgg),
          Text('Mô tả :'+mota),
          Text('Price: ' + price.toString(),),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "USE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            String id = StaticData.userID;
            Map<String, dynamic> row;

            InfoPokemon index = new InfoPokemon(name, 1, rareColor);
            StaticData.PokemonUser.add(index);

            /*if (rareColor == Colors.green){
              row = {'MANGUOIDUNG': id,'NAMEPOKEMON': name, 'LEVELPOKEMON': 1,'DOHIEM': 1};
            }
            if (rareColor == Colors.blueAccent){
              row = {'MANGUOIDUNG': id,'NAMEPOKEMON': name, 'LEVELPOKEMON': 1,'DOHIEM': 2};
            }
            if (rareColor == Colors.purpleAccent){
              row = {'MANGUOIDUNG': id,'NAMEPOKEMON': name, 'LEVELPOKEMON': 1,'DOHIEM': 3};
            }
            if (rareColor == Colors.red){
              row = {'MANGUOIDUNG': id,'NAMEPOKEMON': name, 'LEVELPOKEMON': 1,'DOHIEM': 4};
            }
            int i = await DbProvider.instance.insert('POKEMON', row);
            print(i);*/

            final k = await DbProvider.instance.rawQuery('''
          DELETE FROM VATPHAMNGUOIDUNG WHERE MANGUOIDUNG = '$id' AND MAVATPHAM = '$mavp'
          ''');
            for(int i = 0; i < StaticData.EggUser.length; i++)
            {
              if(StaticData.EggUser[i].MaVP == mavp)
              {
                setState(() {
                  StaticData.EggUser.removeAt(i);
                });
              }
            }
            print(StaticData.PokemonUser);
            Navigator.pop(context);
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}





