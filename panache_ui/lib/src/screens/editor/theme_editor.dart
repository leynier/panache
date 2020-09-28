import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/panels/bottom_sheet_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/button_bar_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/card_theme_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/color_scheme_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/divider_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/float_action_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/materiel_banner_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/navigation_rail_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/popup_menu_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/snack_bar_theme_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/time_picker_panel.dart';
import 'package:panache_ui/src/screens/editor/panels/tootlip_panel.dart';
import 'panels/bottom_navigation_bar_panel.dart';
import 'panels/toggle_button_panel.dart';
import 'panels/app_bar_theme_panel.dart';
import 'panels/bottom_app_bar_theme_panel.dart';

import 'action_bar.dart';
import 'panel_header.dart';
import 'panels/dialog_theme_panel.dart';
import 'panels/icon_theme_panel.dart';
import 'panels/input_decoration_theme_panel.dart';
import 'panels/panels.dart';

class ThemeEditor extends StatefulWidget {
  final ThemeModel model;

  const ThemeEditor({this.model, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ThemeEditorState();
}

class ThemeEditorState extends State<ThemeEditor> {
  bool colorPanelExpanded = false;
  bool colorSchemePanelExpanded = false;

  bool buttonThemePanelExpanded = false;
  bool iconThemePanelExpanded = false;
  bool sliderThemePanelExpanded = false;
  bool tabBarThemePanelExpanded = false;
  bool chipThemePanelExpanded = false;
  bool dialogThemePanelExpanded = false;
  bool textPanelExpanded = false;
  bool primaryTextPanelExpanded = false;
  bool accentTextPanelExpanded = false;
  bool inputsPanelExpanded = false;

  bool appBarThemePanelExpanded = false;
  bool bottomAppBarThemePanelExpanded = false;
  bool bottomNavigationBarPanelExpanded = false;
  bool toggleButtonPanelExpanded = false;
  bool cardPanelExpanded = false;
  bool tooltipPanelExpanded = false;
  bool snackBarPanelExpanded = false;
  bool bottomSheetPanelExpanded = false;
  bool popupMenuPanelExpanded = false;
  bool timePickerPanelExpanded = false;
  bool buttonBarPanelExpanded = false;
  bool floatActionPanelExpanded = false;
  bool materialBannerPanelExpanded = false;
  bool dividerPanelExpanded = false;
  bool navigationRailPanelExpanded = false;

  ScrollController scrollController;

  @override
  void initState() {
    print('widget.model.scrollPosition ${widget.model.scrollPosition}');
    _initPanels();

    scrollController =
        ScrollController(initialScrollOffset: widget.model.scrollPosition ?? 0)
          ..addListener(() {
            widget.model.saveScrollPosition(scrollController.position.pixels);
          });

    super.initState();
  }

  void _initPanels() {
    Map<String, dynamic> panelStates = widget.model.panelStates;
    colorPanelExpanded = panelStates['colorPanelExpanded'];
    colorSchemePanelExpanded = panelStates['colorSchemePanelExpanded'];
    buttonThemePanelExpanded = panelStates['buttonThemePanelExpanded'];
    iconThemePanelExpanded = panelStates['iconThemePanelExpanded'];
    sliderThemePanelExpanded = panelStates['sliderThemePanelExpanded'];
    tabBarThemePanelExpanded = panelStates['tabBarThemePanelExpanded'];
    chipThemePanelExpanded = panelStates['chipThemePanelExpanded'];
    textPanelExpanded = panelStates['textPanelExpanded'];
    primaryTextPanelExpanded = panelStates['primaryTextPanelExpanded'];
    accentTextPanelExpanded = panelStates['accentTextPanelExpanded'];
    inputsPanelExpanded = panelStates['accentTextPanelExpanded'];

    appBarThemePanelExpanded = panelStates['appBarThemePanelExpanded'];
    bottomAppBarThemePanelExpanded =
        panelStates['bottomAppBarThemePanelExpanded'];
    buttonThemePanelExpanded = panelStates['buttonThemePanelExpanded'];
    bottomNavigationBarPanelExpanded =
        panelStates['bottomNavigationBarPanelExpanded'];
    toggleButtonPanelExpanded = panelStates['toggleButtonPanelExpanded'];
    cardPanelExpanded = panelStates['cardPanelExpanded'];
    tooltipPanelExpanded = panelStates['tooltipPanelExpanded'];
    snackBarPanelExpanded = panelStates['snackBarPanelExpanded'];
    bottomSheetPanelExpanded = panelStates['bottomSheetPanelExpanded'];
    popupMenuPanelExpanded = panelStates['popupMenuPanelExpanded'];
    timePickerPanelExpanded = panelStates['timePickerPanelExpanded'];
    buttonBarPanelExpanded = panelStates['buttonBarPanelExpanded'];
    floatActionPanelExpanded = panelStates['floatActionPanelExpanded'];
    materialBannerPanelExpanded = panelStates['materialBannerPanelExpanded'];
    dividerPanelExpanded = panelStates['dividerPanelExpanded'];
    navigationRailPanelExpanded = panelStates['navigationRailPanelExpanded'];
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = widget.model.theme.primaryColor;
    Orientation orientation = MediaQuery.of(context).orientation;
    bool inPortrait = orientation == Orientation.portrait;
    bool useLargeLayout = MediaQuery.of(context).size.shortestSide >= 600;

    return Container(
      /*elevation: 4,*/
      color: Colors.blueGrey.shade100,
      child: ListView(
        controller: scrollController,
        /*shrinkWrap: true,*/
        children: [
          GlobalThemePropertiesControl(),
          ExpansionPanelList(
            expansionCallback: _onExpansionPanelUpdate,
            children: [
              _buildPanel(
                widget.model,
                'Colors',
                child: ThemeColorPanel(widget.model),
                expanded: colorPanelExpanded,
                icon: Icons.format_color_fill,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'ColorScheme',
                child: ColorSchemeThemePanel(widget.model),
                expanded: colorSchemePanelExpanded,
                icon: Icons.color_lens,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Button Theme',
                child: ButtonThemePanel(widget.model),
                expanded: buttonThemePanelExpanded,
                icon: Icons.touch_app,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Inputs',
                child: InputDecorationThemePanel(
                    widget.model, widget.model.theme.inputDecorationTheme),
                expanded: inputsPanelExpanded,
                icon: Icons.keyboard,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'TabBar Theme',
                child: TabBarThemePanel(widget.model),
                expanded: tabBarThemePanelExpanded,
                icon: Icons.tab,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Slider Theme',
                child: SliderThemePanel(widget.model),
                expanded: sliderThemePanelExpanded,
                icon: Icons.tune,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Text Theme',
                child: TypographyThemePanel(
                  model: widget.model,
                  txtTheme: widget.model.theme.textTheme,
                  txtThemeRef: 'textTheme',
                ),
                expanded: textPanelExpanded,
                icon: Icons.font_download,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Primary Text Theme',
                child: TypographyThemePanel(
                    model: widget.model,
                    txtThemeRef: 'primaryTextTheme',
                    txtTheme: widget.model.theme.primaryTextTheme),
                expanded: primaryTextPanelExpanded,
                icon: Icons.font_download,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Accent Text Theme',
                child: TypographyThemePanel(
                    model: widget.model,
                    txtThemeRef: 'accentTextTheme',
                    txtTheme: widget.model.theme.accentTextTheme),
                expanded: accentTextPanelExpanded,
                icon: Icons.font_download,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Chips Theme',
                child: ChipThemePanel(widget.model),
                expanded: chipThemePanelExpanded,
                icon: Icons.dns,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Icon Themes',
                child: IconThemePanel(widget.model),
                expanded: iconThemePanelExpanded,
                icon: Icons.insert_emoticon,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Dialog Theme',
                child: DialogThemePanel(widget.model),
                expanded: dialogThemePanelExpanded,
                icon: Icons.check_box_outline_blank,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'AppBar Theme',
                child: AppBarThemePanel(widget.model),
                expanded: appBarThemePanelExpanded,
                icon: Icons.border_top,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Bottom AppBar Theme',
                child: BottomAppBarThemePanel(widget.model),
                expanded: bottomAppBarThemePanelExpanded,
                icon: Icons.border_all,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Bottom AppBar Navigation Theme',
                child: BottomNavigationBarThemePanel(widget.model),
                expanded: bottomNavigationBarPanelExpanded,
                icon: Icons.border_bottom,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'ToggleButton Theme',
                child: ToggleButtonThemePanel(widget.model),
                expanded: toggleButtonPanelExpanded,
                icon: Icons.storage,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Card Theme',
                child: CardThemePanel(widget.model),
                expanded: cardPanelExpanded,
                icon: Icons.credit_card,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Tooltip Theme',
                child: TooltipThemePanel(widget.model),
                expanded: tooltipPanelExpanded,
                icon: Icons.message,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'SnackBar Theme',
                child: SnackBarThemePanel(widget.model),
                expanded: snackBarPanelExpanded,
                icon: Icons.space_bar,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'BottomSheet Theme',
                child: BottomSheetThemePanel(widget.model),
                expanded: bottomSheetPanelExpanded,
                icon: Icons.bookmark_border,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'PopupMenu Theme',
                child: PopupMenuThemePanel(widget.model),
                expanded: popupMenuPanelExpanded,
                icon: Icons.check_box_outline_blank,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'TimePicker Theme',
                child: TimePickerThemePanel(widget.model),
                expanded: timePickerPanelExpanded,
                icon: Icons.access_time,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'ButtonBar Theme',
                child: ButtonBarThemePanel(widget.model),
                expanded: buttonBarPanelExpanded,
                icon: Icons.view_agenda,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'FloatAction Theme',
                child: FloatActionThemePanel(widget.model),
                expanded: floatActionPanelExpanded,
                icon: Icons.add_circle_outline,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'MaterialBanner Theme',
                child: MaterialBannerThemePanel(widget.model),
                expanded: materialBannerPanelExpanded,
                icon: Icons.call_to_action,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'Divider Theme',
                child: DividerThemePanel(widget.model),
                expanded: dividerPanelExpanded,
                icon: Icons.format_line_spacing,
                color: primaryColor,
                dense: !useLargeLayout,
              ),
              _buildPanel(
                widget.model,
                'NavigationRail Theme',
                child: NavigationRailThemePanel(widget.model),
                expanded: navigationRailPanelExpanded,
                icon: Icons.navigation,
                color: primaryColor,
                dense: !useLargeLayout,
              )
            ],
          )
        ],
      ),
    );
  }

  void _onExpansionPanelUpdate(int panelIndex, bool isExpanded) {
    switch (panelIndex) {
      case 0:
        colorPanelExpanded = !isExpanded;
        break;
      case 1:
        colorSchemePanelExpanded = !isExpanded;
        break;
      case 2:
        buttonThemePanelExpanded = !isExpanded;
        break;
      case 3:
        inputsPanelExpanded = !isExpanded;
        break;
      case 4:
        tabBarThemePanelExpanded = !isExpanded;
        break;
      case 5:
        sliderThemePanelExpanded = !isExpanded;
        break;
      case 6:
        textPanelExpanded = !isExpanded;
        break;
      case 7:
        primaryTextPanelExpanded = !isExpanded;
        break;
      case 8:
        accentTextPanelExpanded = !isExpanded;
        break;
      case 9:
        chipThemePanelExpanded = !isExpanded;
        break;
      case 10:
        iconThemePanelExpanded = !isExpanded;
        break;
      case 11:
        dialogThemePanelExpanded = !isExpanded;
        break;
      case 12:
        appBarThemePanelExpanded = !isExpanded;
        break;
      case 13:
        bottomAppBarThemePanelExpanded = !isExpanded;
        break;
      case 14:
        bottomNavigationBarPanelExpanded = !isExpanded;
        break;
      case 15:
        toggleButtonPanelExpanded = !isExpanded;
        break;
      case 16:
        cardPanelExpanded = !isExpanded;
        break;
      case 17:
        tooltipPanelExpanded = !isExpanded;
        break;
      case 18:
        snackBarPanelExpanded = !isExpanded;
        break;
      case 19:
        bottomSheetPanelExpanded = !isExpanded;
        break;
      case 20:
        popupMenuPanelExpanded = !isExpanded;
        break;
      case 21:
        timePickerPanelExpanded = !isExpanded;
        break;
      case 22:
        buttonBarPanelExpanded = !isExpanded;
        break;
      case 23:
        floatActionPanelExpanded = !isExpanded;
        break;
      case 24:
        materialBannerPanelExpanded = !isExpanded;
        break;
      case 25:
        dividerPanelExpanded = !isExpanded;
        break;
      case 26:
        navigationRailPanelExpanded = !isExpanded;
        break;
    }

    Map<String, bool> panelStates = <String, bool>{
      'colorPanelExpanded': colorPanelExpanded,
      'colorSchemePanelExpanded': colorSchemePanelExpanded,
      'buttonThemePanelExpanded': buttonThemePanelExpanded,
      'inputsPanelExpanded': inputsPanelExpanded,
      'tabBarThemePanelExpanded': tabBarThemePanelExpanded,
      'sliderThemePanelExpanded': sliderThemePanelExpanded,
      'textPanelExpanded': textPanelExpanded,
      'primaryTextPanelExpanded': primaryTextPanelExpanded,
      'accentTextPanelExpanded': accentTextPanelExpanded,
      'chipThemePanelExpanded': chipThemePanelExpanded,
      'iconThemePanelExpanded': iconThemePanelExpanded,
      'dialogThemePanelExpanded': dialogThemePanelExpanded,
      'appBarThemePanelExpanded': appBarThemePanelExpanded,
      'bottomAppBarThemePanelExpanded': bottomAppBarThemePanelExpanded,
      'bottomNavigationBarPanelExpanded': bottomNavigationBarPanelExpanded,
      'toggleButtonPanelExpanded': toggleButtonPanelExpanded,
      'cardPanelExpanded': cardPanelExpanded,
      'tooltipPanelExpanded': tooltipPanelExpanded,
      'snackBarPanelExpanded': snackBarPanelExpanded,
      'bottomSheetPanelExpanded': bottomSheetPanelExpanded,
      'popupMenuPanelExpanded': popupMenuPanelExpanded,
      'timePickerPanelExpanded': timePickerPanelExpanded,
      'buttonBarPanelExpanded': buttonBarPanelExpanded,
      'floatActionPanelExpanded': floatActionPanelExpanded,
      'materialBannerPanelExpanded': materialBannerPanelExpanded,
      'dividerPanelExpanded': dividerPanelExpanded,
      'navigationRailPanelExpanded': navigationRailPanelExpanded
    };
    widget.model.saveEditorState(panelStates, scrollController.position.pixels);

    setState(() {});
  }

  ExpansionPanel _buildPanel(ThemeModel model, String label,
      {bool expanded = false,
      IconData icon,
      Color color,
      Widget child,
      bool dense}) {
    return ExpansionPanel(
      isExpanded: expanded ?? false,
      headerBuilder: (BuildContext context, bool isExpanded) => ExpanderHeader(
        icon: icon,
        color: color,
        label: label,
        dense: dense,
      ),
      body: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<bool>('colorPanelExpanded', colorPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'buttonThemePanelExpanded', buttonThemePanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'iconThemePanelExpanded', iconThemePanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'sliderThemePanelExpanded', sliderThemePanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'tabBarThemePanelExpanded', tabBarThemePanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'chipThemePanelExpanded', chipThemePanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'dialogThemePanelExpanded', dialogThemePanelExpanded));
    properties
        .add(DiagnosticsProperty<bool>('textPanelExpanded', textPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'primaryTextPanelExpanded', primaryTextPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'accentTextPanelExpanded', accentTextPanelExpanded));
    properties.add(
        DiagnosticsProperty<bool>('inputsPanelExpanded', inputsPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'appBarThemePanelExpanded', appBarThemePanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'bottomAppBarThemePanelExpanded', bottomAppBarThemePanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'bottomNavigationBarPanelExpanded', bottomNavigationBarPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'toggleButtonPanelExpanded', toggleButtonPanelExpanded));
    properties
        .add(DiagnosticsProperty<bool>('cardPanelExpanded', cardPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'tooltipPanelExpanded', tooltipPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'snackBarPanelExpanded', snackBarPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'bottomSheetPanelExpanded', bottomSheetPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'popupMenuPanelExpanded', popupMenuPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'timePickerPanelExpanded', timePickerPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'buttonBarPanelExpanded', buttonBarPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'floatActionPanelExpanded', floatActionPanelExpanded));
    properties.add(DiagnosticsProperty<ScrollController>(
        'scrollController', scrollController));
    properties.add(DiagnosticsProperty<bool>(
        'materialBannerPanelExpanded', materialBannerPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'dividerPanelExpanded', dividerPanelExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'navigationRailPanelExpanded', navigationRailPanelExpanded));
  }
}
