import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // TODO: Would get these locations from a database instead -- For now could just use a JSON file?
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    //Building the widgets (locations to visit)
    Image imageSection = _buildImageWidget('images/lake.jpg');

    Widget titleSection = Container(
      child: _buildTitleWidget(
          'Oeschinen Lake Campground', 'Kandersteg, Switzerland'),
    );

    String txt =
        """Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through 
pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.""";

    Widget textSection = Container(
      child: _buildTextWidget(txt),
    );

    //Creating the button section
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    ); // !location 1

    //Location 2
    Image canyonImageSection = _buildImageWidget('images/canyon.jpg');

    Widget canyonTitleSection = Container(
      child: _buildTitleWidget('Grand Canyon', 'Arizona, United States'),
    );

    String canyonTextString =
        """The Grand Canyon in Arizona is a natural formation distinguished by layered bands of red rock, revealing millions of years of geological history in cross-section. Vast in scale, the canyon averages 10 miles across and 
a mile deep along its 277-mile length. Much of the area is a national park, with Colorado River white-water rapids and sweeping vistas.""";

    Widget canyonTextSection = Container(
      child: _buildTextWidget(canyonTextString),
    );

    Widget canyonButtonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    ); //! location 2

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            //Location 1
            imageSection,
            titleSection,
            buttonSection,
            textSection,

            //Location 2
            canyonImageSection,
            canyonTitleSection,
            canyonButtonSection,
            canyonTextSection,
          ],
        ),
      ),
    );
  }

  //Helper methods create to keep code DRY - allows me to reuse code to add new content
  Image _buildImageWidget(String fileLocation) {
    return Image.asset(
      fileLocation,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  } //!_buildImageWidget

  //A method that returns a location to visit and whereabouts (keeps code DRY)
  Container _buildTitleWidget(String place, String location) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            //1
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //2
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    place,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          //3
          const FavoriteWidget(),
        ],
      ),
    );
  }

  //A method that builds the buttonSection to keep code DRY
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  //A method that builds the textSection
  Padding _buildTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        text,
        softWrap: true,
      ),
    );
  } // !_buildTextWidget
}

//Creating our own widget that will be responsible for favouriting an item
class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }

  //Is called when onPressed event is provoked
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}
