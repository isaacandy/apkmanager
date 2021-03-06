#! /bin/sh
# -----------------------------------------------------------------------
# Apk Manager OS X v3.0+
# Application menus
#
# by Jocelyn Mallon CC by-nc-sa 2012
# http://girlintroverted.wordpress.com
#
# version: 3.2b
# Mon. Jan 27, 2014
# -----------------------------------------------------------------------

# Advanced signing menu
sign_menu () {
    if [[ -z $keystore ]]; then
        storecheck
    fi
    cd "${maindir}"
    clear
    menu_header
    echo $bgreen"--------------------------------------"$bwhite"Advanced Signing Options"$bgreen"--------------------------------------"
    echo $white" Current Keystore: "$bgreen"${keystore}"; $rclr;
    echo $green" (if \"None\" displayed, please use create new private key option first)"
    echo $bgreen"$apkmspr"
    echo $bgreen"  1   "$white"Create a new private key "$blue"(Will be stored in \$HOME/.apkmanager/.keystores)";
    echo $bgreen"  2   "$white"Select an existing keystore to use";
    echo $bgreen"  3   "$white"Sign an apk/jar file with private key";
    echo $bgreen"  4   "$white"Verify signed apk/jar";
    echo $bgreen"  5   "$white"Batch sign with private key "$blue"(Inside ${sig_dir} folder)";
    echo $bgreen"  6   "$white"Batch Verify signed apk/jar files "$blue"(Inside ${sig_dir} folder)";
    echo $bgreen"  7   "$white"Save default keystore selection "$blue"(If you have multiple keystores)";
    echo $bgreen"  8   "$white"Delete selected keystore and private key "$bred"(PLEASE USE WITH CAUTION)";
    echo $bgreen"  Q   "$white"Return to main menu";
    echo $bgreen"$apkmftr";
    printf "$bwhite%s""Please select an option from above: "; $rclr;
    read input
    case "$input" in
         1)  createpkey; sign_menu ;;
         2)  listpkeys; sign_menu ;;
         3)  sign_apk_pk; sign_menu ;;
         4)  single_vrfy; sign_menu ;;
         5)  batch_sign_pk; sign_menu ;;
         6)  batch_vrfy; sign_menu ;;
         7)  savekey; sign_menu ;;
         8)  delkey; sign_menu ;;
        96)  toggle_trace; sign_menu ;;
        97)  toggle_verbose; sign_menu ;;
        98)  toggle_error; sign_menu ;;
        99)  basic_debug; sign_menu ;;
  [sS][sS])  ret_menu="sign_menu"; adb_screenshot; unset ret_menu ;;
      [qQ])  signcleanup ;;
  [qQ][qQ])  quit ;;
         *)  input_err; sign_menu ;;
    esac
}

# Clean files/folders menu
clean_menu () {
    cd "${maindir}"
    clear
    menu_header
    echo $bgreen"---------------------------------------"$bwhite"Clean Files or Folders"$bgreen"---------------------------------------";
    echo $bgreen"  1   "$white"Clean This Project's Folder";
    echo $bgreen"  2   "$white"Clean All Files in Modding Folder";
    echo $bgreen"  3   "$white"Clean All Files in OGG Folder";
    echo $bgreen"  4   "$white"Clean All Files in Batch Optimize Folder";
    echo $bgreen"  5   "$white"Clean All Files in Signing Folder";
    echo $bgreen"  6   "$white"Clean All Projects";
    echo $bgreen"  7   "$white"Clean APKtool framework files";
    echo $bgreen"  8   "$white"Clean All Files/Folders "$blue"(Executes options 1-7)";
    echo $bgreen"  9   "$white"Clean LOG.txt and adblog.txt Files";
    echo $bgreen"--------------------------------------"$bwhite"Reset Persistent Options"$bgreen"--------------------------------------";
    echo $bgreen"  10  "$white"Reset log viewer app";
    echo $bgreen"  11  "$white"Reset \"persistent\" Java heap memory size"$blue" (If enabled)";
    echo $bgreen"  12  "$white"Reset \"persistent\" Zip compression level"$blue" (If enabled)";
    echo $bgreen"  13  "$white"Reset \"persistent\" keystore selection"$blue" (If enabled)";
    echo $bgreen"  14  "$white"Reset \"persistent\" png optimization tool selection";
    echo $bgreen"  15  "$white"Reset \"persistent\" ADB device selection"$blue" (If enabled)";
    echo $bgreen"  16  "$white"Reset apktool to newest version"$blue" (Can be set manually in the debug menu)";
    echo $bgreen"  17  "$white"Reset \"debug\" information"$blue" (Next launch of debug menu will be slow)";
    echo $bgreen"  18  "$white"Reset/Change terminal color scheme selection";
    echo $bgreen"  Q   "$white"Return to Main Menu";
    echo $bgreen"$apkmftr";
    printf "$bwhite%s""Please select an option from above: "; $rclr;
    read input
    case "$input" in
         1)  clean_capp ;;
         2)  clean_modding ;;
         3)  clean_ogg ;;
         4)  clean_batch ;;
         5)  clean_signing ;;
         6)  clean_projects ;;
         7)  clean_apktool ;;
         8)  clean_all ;;
         9)  clean_logs ;;
        10)  clean_viewer ;;
        11)  clean_heapsize ;;
        12)  clean_complvl ;;
        13)  clean_keystore ;;
        14)  clean_pngtool ;;
        15)  clean_adb_device ;;
        16)  clean_apktjar ;;
        17)  clean_debug ;;
        18)  clean_color ;;
        96)  toggle_trace ;;
        97)  toggle_verbose ;;
        98)  toggle_error ;;
        99)  basic_debug ;;
  [sS][sS])  ret_menu="clean_menu"; adb_screenshot; unset ret_menu ;;
      [qQ])  cmcleanup  ;;
  [qQ][qQ])  quit ;;
         *)  input_err; clean_menu ;;
    esac
}

# Text app/editor menu
textapp_menu () {
    cd "${maindir}"
    clear
    menu_header
    debug_header
    echo $bgreen"------------------------------------"$bwhite"Set editor for log/txt files"$bgreen"------------------------------------";
    echo $bgreen"  1   "$white"Apple TextEdit"$blue" (Default)";
    echo $bgreen"  2   "$white"TextMate";
    echo $bgreen"  3   "$white"SubEthaEdit";
    echo $bgreen"  4   "$white"TextWrangler";
    echo $bgreen"  5   "$white"BBEDIT";
    echo $bgreen"  6   "$white"Coda";
    echo $bgreen"  7   "$white"MacVIM";
    echo $bgreen"  8   "$white"Aquamacs";
    echo $bgreen"  9   "$white"Smultron";
    echo $bgreen"  10  "$white"Vico";
    echo $bgreen"  11  "$white"Sublime Text 2 (or 3)";
    echo $bgreen"  12  "$white"Chocolat";
    echo $bgreen"  13  "$white"Nano "$blue"(In new terminal tab)";
    echo $bgreen"  14  "$white"Emacs "$blue"(In new terminal tab)";
    echo $bgreen"  15  "$white"vi/vim "$blue"(In new terminal tab)";
    echo $bgreen"  Q   "$white"Return to Debug Menu";
    echo $bgreen"$apkmftr";
    printf "$bwhite%s""Please select an option from above: "; $rclr;
    read input
    case "$input" in
         1)  logviewer="open"; logvchk ;;
         2)  logviewer="mate"; logvchk ;;
         3)  logviewer="see"; logvchk ;;
         4)  logviewer="edit"; logvchk ;;
         5)  logviewer="bbedit"; logvchk ;;
         6)  logviewer="coda"; logvchk ;;
         7)  logviewer="mvim"; logvchk ;;
         8)  logviewer="aquamacs"; logvchk ;;
         9)  logviewer="smultron"; logvchk ;;
        10)  logviewer="vico"; logvchk ;;
        11)  logviewer="subl"; logvchk ;;
        12)  logviewer="choc"; logvchk ;;
        13)  logviewer="nano"; logvchk ;;
        14)  logviewer="emacs"; logvchk ;;
        15)  logviewer="vi"; logvchk ;;
        96)  toggle_trace ;;
        97)  toggle_verbose ;;
        98)  toggle_error ;;
        99)  basic_debug ;;
  [sS][sS])  ret_menu="textapp_menu"; adb_screenshot; unset ret_menu ;;
      [qQ])  ;;
  [qQ][qQ])  quit ;;
         *)  input_err; textapp_menu ;;
    esac
}

# Automatic updates menu
updates_menu () {
    clear
    menu_header
    updates_header
    echo $bgreen"$apkmspr"
    echo $bgreen"  1   "$white"Turn automatic updates "$bgreen"ON";
    echo $bgreen"  2   "$white"Turn automatic updates "$bred"OFF";
    echo $bgreen"  3   "$white"Turn update prompt "$bgreen"ON"$blue" (default) (must confirm each update)";
    echo $bgreen"  4   "$white"Turn update prompt "$bred"OFF"$blue" (no confirmation needed before each update)";
    echo $bgreen"  5   "$white"Change update branch/channel "$blue"(master, develop, etc.)";
    echo $bgreen"  6   "$white"Change update frequency "$blue"(how many days to wait between updates)";
    echo $bgreen"  7   "$white"Check for updates now" $blue"(force an early check for new updates)";
    echo $bgreen"  8   "$white"View APK Manager on github "$blue"(https://github.com/jocelynmallon/apkmanager)";
    echo $bgreen"  Q   "$white"Return to Debug Menu";
    echo $bgreen"$apkmftr";
    printf "$bwhite%s""Please select an option from above: "; $rclr;
    read input
    case "$input" in
         1)  enable_auto_updates; updates_menu  ;;
         2)  disable_auto_updates; updates_menu  ;;
         3)  enable_update_prompt; updates_menu  ;;
         4)  disable_update_prompt; updates_menu  ;;
         5)  change_update_branch; updates_menu  ;;
         6)  change_update_freq; updates_menu  ;;
         7)  force_update_check; updates_menu  ;;
         8)  open https://github.com/jocelynmallon/apkmanager; updates_menu  ;;
        96)  toggle_trace; updates_menu  ;;
        97)  toggle_verbose; updates_menu  ;;
        98)  toggle_error; updates_menu  ;;
        99)  basic_debug; updates_menu  ;;
  [sS][sS])  ret_menu="updates_menu"; adb_screenshot; unset ret_menu ;;
      [qQ])  updates_cleanup ;;
  [qQ][qQ])  quit ;;
         *)  input_err; updates_menu ;;
    esac
}

# ADB setup and tools menu
adb_menu () {
    clear
    menu_header
    debug_header
    echo $bgreen"--------------------------------------"$bwhite"ADB tools, settings, etc"$bgreen"--------------------------------------";
    echo $bgreen"  1   "$white"Select default ADB device "$blue"(temporary, resets on every launch)";
    echo $bgreen"  2   "$white"Connect a new device over wireless ADB "$blue"(ensure you know the IP address and port of device)";
    echo $bgreen"  3   "$white"Connect to saved device over wireless ADB "$blue"(Only if saved device was using wireless ADB)";
    echo $bgreen"  4   "$white"Make default ADB device persistent "$bred"(IF USING WIRELESS ADB, MUST HAVE STATIC IP)";
    echo $bgreen"  5   "$white"Quick ADB log file "$blue"(capture ADB logcat for 10 seconds)";
    echo $bgreen"  6   "$white"Extended ADB log file "$blue"(capture ADB logcat for a user specified number of seconds)";
    echo $bgreen"  7   "$white"Open an ADB shell session "$blue"(select a default ADB device first)";
    echo $bgreen"  8   "$white"Manually restart ADB daemon on device as "$bpink"root "$blue"(select a default ADB device first)";
    echo $bgreen"  9   "$white"Toggle killing ADB daemon on quit" $blue"(currently: "$(adb_kill_display);
    echo $bgreen"  10  "$white"Restart ADB daemon" $blue"(must reconnect wireless ADB sessions afterwards)";
    echo $bgreen"  11  "$white"Enable \"hidden\" "$bpink"SS"$white" option to take an ADB screencap from most menus "$blue"(currently: "$(adb_screencap_display);
    echo $bgreen"  12  "$white"Toggle checking/connecting to saved ADV device on startup" $blue"(currently: "$(adb_connect_start_display)
    echo $bgreen"  Q   "$white"Return to Debug Menu";
    echo $bgreen"$apkmftr";
    printf "$bwhite%s""Please select an option from above: "; $rclr;
    read input
    case "$input" in
         1)  adb_devices_menu; adb_menu  ;;
         2)  adb_wireless_connect; adb_menu  ;;
         3)  adbsaved=1; adb_wireless_connect; unset adbsaved; adb_menu  ;;
         4)  adb_save_device_pref; adb_menu  ;;
         5)  adb_log_device_check; adb_menu  ;;
         6)  extended_adb_log=1; adb_log_device_check; adb_menu  ;;
         7)  adb_shell; adb_menu  ;;
         8)  adbrootforce=1; adb_root_setup; unset adbrootforce; adb_menu  ;;
         9)  toggle_adb_kill_on_quit; adb_menu  ;;
        10)  adb kill-server; adb start-server >/dev/null; adb_menu  ;;
        11)  adb_screencap_toggle; adb_menu ;;
        12)  adb_connect_on_start_toggle; adb_menu  ;;
        96)  toggle_trace; adb_menu  ;;
        97)  toggle_verbose; adb_menu  ;;
        98)  toggle_error; adb_menu  ;;
        99)  basic_debug; adb_menu  ;;
  [sS][sS])  ret_menu="adb_menu"; adb_screenshot; unset ret_menu ;;
      [qQ])  ;;
  [qQ][qQ])  quit ;;
         *)  input_err; adb_menu ;;
    esac
}

# Debug & Settings menu
debug_menu () {
    debug_check
    if [[ -z $apktool_ver ]]; then
        getapktver
    fi
    cd "${maindir}"
    clear
    menu_header
    debug_header
    echo $bgreen"$apkmspr";
    echo $bgreen"  1   "$white"Set editor for log/txt files";
    echo $bgreen"  2   "$white"View binary info, paths, etc. ";
    echo $bgreen"  3   "$white"View README" $blue"(opens wiki on github)";
    echo $bgreen"  4   "$white"View CHANGELOG/COMMIT History";
    echo $bgreen"  5   "$white"View TIPS" $blue"(opens wiki on github)";
    echo $bgreen"  6   "$white"View LOG.txt";
    echo $bgreen"  7   "$white"View ADBLOG.txt "$blue"(if file exists)";
    echo $bgreen"  8   "$white"Configure automatic updates "$blue"(Requires you have \"git\" installed)";
    echo $bgreen"  9   "$white"Toggle command line use "$blue"(create/delete \"apkm\" symlink in /usr/local/bin)";
    echo $bgreen"-----------------------------------------"$bwhite"Other misc options"$bgreen"-----------------------------------------";
    echo $bgreen"  10  "$white"Enable persistent Java Heap memory size";
    echo $bgreen"  11  "$white"Enable persistent Zip Compression Level";
    echo $bgreen"  12  "$white"Select tool to use for PNG optimization options "$green"(Persistent)";
    echo $bgreen"  13  "$white"Select Android SDK tools version "$bred"(ONLY IF USING ANDROID STUDIO)";
    echo $bgreen"  14  "$white"Launch draw9patch "$blue"(Requires you have Android SDK installed)";
    echo $bgreen"  15  "$white"Launch Android Device Monitor "$blue"(previously ddms, Requires you have Android SDK installed)";
    echo $bgreen"  16  "$white"Launch Android SDK Manager "$blue"(Requires you have Android SDK installed)";
    echo $bgreen"  17  "$white"ADB Tools "$blue"(logcat, shell, wireless ADB setup, etc.)";
    echo $bgreen"  18  "$white"Choose APKtool version "$blue"(For decompiling/compiling apk files)";
    echo $bgreen"  Q   "$white"Return to Main Menu";
    echo $bgreen"$apkmftr";
    printf "$bwhite%s""Please select an option from above: "; $rclr;
    read input
    case "$input" in
         1)  textapp_menu ; debug_menu ;;
         2)  debug_display; debug_menu ;;
         3)  open https://github.com/jocelynmallon/apkmanager/wiki; debug_menu ;;
         4)  view_changelog; debug_menu ;;
         5)  open https://github.com/jocelynmallon/apkmanager/wiki/General-Tips; debug_menu ;;
         6)  txt="$log" 2>> "$log"; read_txt; debug_menu ;;
         7)  read_adb_log; debug_menu ;;
         8)  updates_git_check; debug_menu ;;
         9)  apkm_tool_toggle; debug_menu ;;
        10)  local key="heap" && local value="$heapy" && write_preference && heap_size; debug_menu ;;
        11)  local key="complvl" && local value="$uscr" && write_preference && comp_level; debug_menu ;;
        12)  png_tool_menu; debug_menu ;;
        13)  andsdk_tools_check; debug_menu ;;
        14)  draw_nine; debug_menu ;;
        15)  launch_ddms; debug_menu ;;
        16)  launch_sdk_manager; debug_menu ;;
        17)  adb_menu; debug_menu ;;
        18)  apkt_menu_check; debug_menu ;;
        96)  toggle_trace; debug_menu ;;
        97)  toggle_verbose; debug_menu ;;
        98)  toggle_error; debug_menu ;;
        99)  basic_debug; debug_menu ;;
  [sS][sS])  ret_menu="debug_menu"; adb_screenshot; unset ret_menu ;;
      [qQ])  debug_cleanup ;;
  [qQ][qQ])  quit ;;
         *)  input_err; debug_menu ;;
    esac
}

# Main Menu
restart () {
    cd "${maindir}"
    menu_header
    echo $bgreen"---------------------------------"$bwhite"Simple Tasks Such As Image Editing"$bgreen"---------------------------------";
    echo $bgreen"  1   "$white"ADB pull "$blue"(Pulls file into \"${mod_dir}\" folder)";
    echo $bgreen"  2   "$white"Extract APK ";
    echo $bgreen"  3   "$white"Optimize images inside "$blue"(Only if \"Extract APK\" was selected)";
    echo $bgreen"  4   "$white"Compile \".9.png\" and/or binary xml files";
    echo $bgreen"  5   "$white"Zip APK ";
    echo $bgreen"  6   "$white"Sign APK "$blue"(With test keys) "$bred"(DON'T do this if its a system apk)";
    echo $bgreen"  7   "$white"Zipalign APK "$blue"(Do this after apk is zipped / signed)";
    echo $bgreen"  8   "$white"Install APK "$bred"(DON'T do this if system apk, do adb push)";
    echo $bgreen"  9   "$white"Zip / Sign / Install APK "$blue"(All in one step)" $bred"(apk files only)";
    echo $bgreen"  10  "$white"ADB push "$bred"(Only for system apk/jar file)";
    echo $bgreen"--------------------------------"$bwhite"Advanced Tasks Such As Code Editing"$bgreen"---------------------------------";
    echo $bgreen"  11  "$white"Decompile "$blue"(Supports both apk and jar files)";
    echo $bgreen"  12  "$white"Decompile with dependencies"$blue" (For propietary rom APKs)" $bred"(APK files only)";
    echo $bgreen"  13  "$white"Advanced Decompile APK "$blue"(Uses baksmali for code, apktool for resources)";
    echo $bgreen"  14  "$white"Compile "$blue"(For use with decompile options: 11, 12, 13)";
    echo $bgreen"  15  "$white"Compile / Sign / Install "$blue"(All in one step) "$bred"(apk files only)";
    echo $bgreen"  16  "$white"Advanced \"All-in-one\" "$blue"(Zip/Compile, sign with private keys, install)";
    echo $bgreen"  17  "$white"Uninstall APK "$blue"(Only for non-system apps)";
    echo $bgreen"  18  "$white"View Java Source "$blue"(apk and jar support) "$bred"(CANNOT be recompiled)";
    echo $bgreen"  19  "$white"Advanced signing options "$blue"(Use your own keystore, verify signatures, etc.)";
    echo $bgreen"-------------------------------------------"$bwhite"Other Options"$bgreen"--------------------------------------------";
    echo $bgreen"  20  "$white"Batch Optimize files "$blue"(Inside \"${bat_dir}\" folder)";
    echo $bgreen"  21  "$white"Batch Sign APK files "$blue"(With test keys, inside \"${sig_dir}\" folder)";
    echo $bgreen"  22  "$white"Batch optimize ogg files "$blue"(Inside \"${ogg_dir}\" only)";
    echo $bgreen"  23  "$white"Select compression level for zipping files";
    echo $bgreen"  24  "$white"Set max Java heap memory size "$blue"(If getting stuck at decompiling/compiling)";
    echo $bgreen"  25  "$white"Debug Info and Misc Settings "$blue"(Persistent heap, set log viewing app, etc.)";
    echo $bgreen"  26  "$white"Clean Files/Folders, Reset settings, etc. "
    echo $bgreen"  27  "$white"Select Current Project";
    echo $bgreen"  Q   "$white"Quit APK Manager";
    echo $bgreen"$apkmftr";
    printf "$bwhite%s""Please select an option from above: "; $rclr;
    read input
    case "$input" in
         1)  adb_pull ;;
         2)  extract_apk ;;
         3)  opt_apk_png ;;
         4)  compile_9patch ;;
         5)  zip_apk ;;
         6)  sign_apk_tk ;;
         7)  zalign_file ;;
         8)  install_apk ;;
         9)  zip_sign_install ;;
        10)  adb_push ;;
        11)  decompile ;;
        12)  decomp_ded ;;
        13)  decompile_adv ;;
        14)  compile ;;
        15)  co_sign_install ;;
        16)  adv_all_in_one ;;
        17)  adb_uninstall_apk ;;
        18)  d2j_check ;;
        19)  sign_menu ;;
        20)  batch_opt; batch_cleanup ;;
        21)  batch_sign_tk; batch_cleanup ;;
        22)  batch_ogg; batch_cleanup ;;
        23)  comp_level ;;
        24)  heap_size ;;
        25)  debug_menu ;;
        26)  clean_menu ;;
        27)  projects_menu ;;
        96)  toggle_trace ;;
        97)  toggle_verbose ;;
        98)  toggle_error ;;
        99)  basic_debug ;;
  [sS][sS])  ret_menu=""; adb_screenshot; unset ret_menu ;;
      [qQ])  quit ;;
  [qQ][qQ])  quit ;;
         *)  input_err ;;
    esac
}
