import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';
import 'package:transparent_image/transparent_image.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;

  const Stories({Key key, @required this.currentUser, @required this.stories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 8.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 1 + stories.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _StoryCard(
                isAddStory: true,
                currentUser: currentUser,
              ),
            );
          }
          final Story story = stories[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _StoryCard(
              story: story,
            ),
          );
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User currentUser;
  final Story story;

  const _StoryCard({
    Key key,
    this.isAddStory = false,
    this.currentUser,
    this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // const Center(child: CircularProgressIndicator()),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: isAddStory ? currentUser.imageUrl : story.imageUrl,
            height: double.infinity,
            width: 110.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110.0,
          decoration: BoxDecoration(
            gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: Responsive.isDesktop(context)
                ? const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4.0),
                  ]
                : null,
          ),
        ),
        // CachedNetworkImage(
        //   imageUrl: imageString, // isAddStory ? currentUser.imageUrl : story.imageUrl,
        //   // imageUrl: imageString,
        //   // https://www.youtube.com/watch?v=HvLb5gdUfDE 40:28
        //   height: double.infinity,
        //   width: 110.0,
        //   fit: BoxFit.cover,
        // ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: isAddStory
              ? CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Palette.scaffold,
                  child: Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                      color: Palette.facebookBlue, // Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      iconSize: 35.0,
                      color: Palette.scaffold,
                      // Palette.facebookBlue,
                      onPressed: () => print('Create Story'),
                    ),
                  ),
                )
              : ProfileAvatar(
                  imageUrl: story.imageUrl,
                  hasBorder: !story.isViewed,
                ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            isAddStory ? 'Create Story' : story.user.name,
            style: TextStyle(
              color: Colors.grey.shade300,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
