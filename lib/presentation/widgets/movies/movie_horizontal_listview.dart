import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {

  final List<Movie> movies;
  final String? label;
  final String? subLabel;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({
    super.key, 
    required this.movies, 
    this.label, 
    this.subLabel, 
    this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {

  final scrollController = ScrollController();

    @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if(widget.loadNextPage == null) return;

      if( (scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
      
    });
  }


  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if(widget.label != null || widget.subLabel != null)
            _Title(title: widget.label, subTitle: widget.subLabel),

          
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                  return FadeInRight(child: _SlideHorizontal(movie: widget.movies[index]));

                },
              )
            )
        ],
      ),
    );
  }
}

class _SlideHorizontal extends StatelessWidget {
  final Movie movie;
  const _SlideHorizontal({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: AspectRatio(
              aspectRatio: 2.8 / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  fit: BoxFit.cover,
                  movie.backdropPath,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress != null){
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator(strokeWidth: 2))
                      );
                    }
                    return GestureDetector(
                      onTap: () => context.push('/movie/${movie.id}'),
                      child: FadeIn(child: child),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.bodySmall,
            ),
          ),

          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon( Icons.star_half_outlined,color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                Text('${movie.voteAverage}', style: textStyle.bodySmall?.copyWith(color: Colors.yellow.shade800)),
                 const Spacer(),
                Text( HumanFormat.number(movie.popularity) ,style: textStyle.bodySmall)
              ],
            ),
          )
          
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {

    final tytleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if(title != null)
            Text(title!, style: tytleStyle),

          const Spacer(),

          if(subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact ),
              onPressed: (){}, 
              child: Text(subTitle!)
            )
        ],
      ),
    );
  }
}