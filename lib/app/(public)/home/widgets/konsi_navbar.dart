// import 'package:design_system/design_system.dart';
// import 'package:flutter/material.dart';

// class PlayflixNavBar extends StatefulWidget {
//   final void Function(String routePath) onNavigate;
//   final List<PlayFlixItemNavBar> items;
//   final bool hasHighlight;

//   const PlayflixNavBar({
//     super.key,
//     required this.items,
//     required this.onNavigate,
//     this.hasHighlight = true,
//   });

//   @override
//   State<PlayflixNavBar> createState() => _PlayflixNavBarState();
// }

// class _PlayflixNavBarState extends State<PlayflixNavBar> {
//   late int _selectedIndex = 0;
//   late bool _hasHighlight = widget.hasHighlight;

//   @override
//   void didUpdateWidget(PlayflixNavBar oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (oldWidget.hasHighlight != widget.hasHighlight) {
//       setState(() {
//         _hasHighlight = widget.hasHighlight;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;
//     final width = mediaQuery.width;
//     const notchWidth = 87.0;
//     const notchHeight = 43.5;
//     final colors = PlayflixColors.of(context);
//     return Stack(
//       children: [
//         CustomPaint(
//           size: Size.fromHeight(const Dimension(7).height),
//           painter: NotchedRectanglePainter(
//             path: RectangularNotchedRectangle(
//               radius: Dimension.sm.value,
//             ).getOuterPath(
//               Rect.fromLTRB(-1, -1, width + 1, mediaQuery.height),
//               Rect.fromLTRB(
//                 (width / 2) - (notchWidth / 2),
//                 0,
//                 (width / 2) + (notchWidth / 2),
//                 notchHeight,
//               ),
//             ),
//             borderColor: colors.greyText,
//           ),
//         ),
//         _buildAppBar(),
//       ],
//     );
//   }

//   Widget _icon(int index) {
//     PlayFlixItemNavBar item = widget.items[index];
//     return IconButton(
//       tooltip: item.label,
//       icon: Icon((index == _selectedIndex) && _hasHighlight
//           ? item.selectedIcon
//           : item.icon),
//       color: (index == _selectedIndex) && _hasHighlight
//           ? PlayflixColors.of(context).mainText
//           : PlayflixColors.of(context).supportText,
//       onPressed: () {
//         setState(() {
//           _selectedIndex = index;
//           _hasHighlight = true;
//         });
//         widget.onNavigate(item.routePath);
//       },
//     );
//   }

//   Widget _buildAppBar() {
//     return BottomAppBar(
//       color: PlayflixColors.of(context).background,
//       shape: RectangularNotchedRectangle(radius: Dimension.sm.value),
//       notchMargin: Dimension.sm.value,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _icon(0),
//           const Spacer(),
//           _icon(1),
//           const Spacer(flex: 5),
//           _icon(2),
//           const Spacer(),
//           _icon(3),
//         ],
//       ),
//     );
//   }
// }

// class RectangularNotchedRectangle extends NotchedShape {
//   final double radius;

//   RectangularNotchedRectangle({
//     this.radius = 8.0,
//   });

//   @override
//   Path getOuterPath(Rect host, Rect? guest) {
//     if (guest == null || !host.overlaps(guest)) {
//       return Path()
//         ..addRRect(RRect.fromRectAndRadius(host, Radius.circular(radius)));
//     }

//     final double notchRadius = radius;
//     final RRect outer = RRect.fromRectAndRadius(host, Radius.circular(radius));
//     final RRect inner =
//         RRect.fromRectAndRadius(guest, Radius.circular(notchRadius));
//     final Radius circular = Radius.circular(Dimension.md.value);
//     return Path()
//       ..moveTo(outer.left, outer.top + radius)
//       ..arcToPoint(Offset(outer.left + radius, outer.top),
//           radius: Radius.circular(radius), clockwise: true)
//       ..lineTo(inner.left - radius, outer.top)
//       ..arcToPoint(Offset(inner.left, outer.top + radius),
//           radius: circular, clockwise: true)
//       ..lineTo(inner.left, inner.bottom - radius)
//       ..arcToPoint(Offset(inner.left + Dimension.md.value, inner.bottom),
//           radius: circular, clockwise: false)
//       ..lineTo(inner.right - radius, inner.bottom)
//       ..arcToPoint(Offset(inner.right, inner.bottom - Dimension.md.value),
//           radius: circular, clockwise: false)
//       ..lineTo(inner.right, outer.top + radius)
//       ..arcToPoint(Offset(inner.right + radius, outer.top),
//           radius: circular, clockwise: true)
//       ..lineTo(outer.right - radius, outer.top)
//       ..arcToPoint(Offset(outer.right, outer.top + radius),
//           radius: Radius.circular(radius), clockwise: true)
//       ..lineTo(outer.right, outer.bottom)
//       ..arcToPoint(Offset(outer.right - radius, outer.bottom),
//           radius: Radius.circular(radius), clockwise: true)
//       ..lineTo(outer.left + radius, outer.bottom)
//       ..arcToPoint(Offset(outer.left, outer.bottom),
//           radius: Radius.circular(radius), clockwise: true)
//       ..close();
//   }
// }

// class NotchedRectanglePainter extends CustomPainter {
//   final Path path;
//   final Color borderColor;

//   NotchedRectanglePainter({required this.path, required this.borderColor});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint fillPaint = Paint()
//       ..color = Colors.transparent
//       ..style = PaintingStyle.fill;
//     final Paint strokePaint = Paint()
//       ..color = borderColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;

//     canvas.drawPath(path, fillPaint);
//     canvas.drawPath(path, strokePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class PlayFlixItemNavBar {
//   final IconData icon;
//   final IconData selectedIcon;
//   final String label;
//   final String routePath;

//   PlayFlixItemNavBar({
//     required this.icon,
//     required this.selectedIcon,
//     required this.label,
//     required this.routePath,
//   });
// }

// class PlayFlixPlayerButton extends StatelessWidget {
//   final VoidCallback callback;
//   const PlayFlixPlayerButton({super.key, required this.callback});

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       elevation: 5,
//       onPressed: callback,
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               spreadRadius: 0,
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Image(
//           image: PlayflixImages.playflixLogo,
//           width: Dimension.md.width,
//           height: Dimension.md.height,
//         ),
//       ),
//     );
//   }
// }
