import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/wall_bloc/wall_events.dart';
import '../../data/bloc/wall_bloc/wallpaper_bloc.dart';

class CustomSearchBar extends StatefulWidget {

  CustomSearchBar({super.key, required this.searchController});

   TextEditingController searchController = TextEditingController();

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(
                controller: widget.searchController,
                onTap: () => setState(() => _isFocused = true),
                onEditingComplete: () => setState(() => _isFocused = false),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.blueGrey[700]),
                  suffixIcon: widget.searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.blueGrey[700]),
                    onPressed: () {
                      widget.searchController.clear();

                    },
                  )
                      : null,
                  hintText: "Search wallpapers...",
                  hintStyle: TextStyle(color: Colors.blueGrey[500]),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  if(widget.searchController.text.isNotEmpty){
                    BlocProvider.of<WallpaperBloc>(context)
                        .add(GetSearchWallpaperEvent(query: widget.searchController.text.toString()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            showCloseIcon: true,
                            content: Text("empty value not found wallpapers")));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
