/*
 * Custom Settings
 */
/* 0102: set START page (0=blank, 1=home, 2=last visited page, 3=resume previous session)
 * [SETTING] General>Startup>When Firefox starts ***/
user_pref("browser.startup.page", 3);
/* 0804: limit history leaks via enumeration (PER TAB: back/forward) - PRIVACY
 * This is a PER TAB session history. You still have a full history stored under all history
 * default=50, minimum=1=currentpage, 2 is the recommended minimum as some pages
 * use it as a means of referral (e.g. hotlinking), 4 or 6 or 10 may be more practical ***/
user_pref("browser.sessionhistory.max_entries", 50);
/* 0807: disable search bar LIVE search suggestions - PRIVACY
 * [SETTING] Search>Provide search suggestions ***/
user_pref("browser.search.suggest.enabled", true);
/* 0808: disable location bar LIVE search suggestions (requires 0807 = true) - PRIVACY
 * Also disable the location bar prompt to enable/disable or learn more about it.
 * [SETTING] Search>Show search suggestions in address bar results ***/
user_pref("browser.urlbar.suggest.searches", true);
user_pref("browser.urlbar.userMadeSearchSuggestionsChoice", true); // (FF41+)
/* 0850a: disable location bar autocomplete and suggestion types
 * If you enforce any of the suggestion types, you MUST enforce 'autocomplete'
 *   - If *ALL* of the suggestion types are false, 'autocomplete' must also be false
 *   - If *ANY* of the suggestion types are true, 'autocomplete' must also be true
 * [SETTING] Privacy & Security>Address Bar>When using the address bar, suggest
 * [WARNING] If all three suggestion types are false, search engine keywords are disabled ***/
user_pref("browser.urlbar.autocomplete.enabled", true);
user_pref("browser.urlbar.suggest.history", true);
user_pref("browser.urlbar.suggest.bookmark", true);
user_pref("browser.urlbar.suggest.openpage", true);
/* 0850c: disable location bar dropdown
 * This value controls the total number of entries to appear in the location bar dropdown
 * [NOTE] Items (bookmarks/history/openpages) with a high "frecency"/"bonus" will always
 * be displayed (no we do not know how these are calculated or what the threshold is),
 * and this does not affect the search by search engine suggestion (see 0808)
 * [USAGE] This setting is only useful if you want to enable search engine keywords
 * (i.e. at least one of 0850a suggestion types must be true) but you want to *limit* suggestions shown ***/
   // user_pref("browser.urlbar.maxRichResults", 0);
/* 0850e: disable location bar one-off searches (FF51+)
 * [1] https://www.ghacks.net/2016/08/09/firefox-one-off-searches-address-bar/ ***/
user_pref("browser.urlbar.oneOffSearches", true);
/* 0850f: disable location bar suggesting local search history (FF57+)
 * [1] https://bugzilla.mozilla.org/1181644 ***/
user_pref("browser.urlbar.maxHistoricalSearchSuggestions", 10); // max. number of search suggestions
/* 0808: disable location bar LIVE search suggestions (requires 0807 = true) - PRIVACY
 * Also disable the location bar prompt to enable/disable or learn more about it.
 * [SETTING] Search>Show search suggestions in address bar results ***/
user_pref("browser.urlbar.suggest.searches", true);
/* 1001: disable disk cache ***/
user_pref("browser.cache.disk.enable", true);
user_pref("browser.cache.disk.capacity", 1048576);
user_pref("browser.cache.disk.smart_size.enabled", true);
user_pref("browser.cache.disk.smart_size.first_run", false);
/** SESSIONS & SESSION RESTORE ***/
/* 1020: disable the Session Restore service completely
 * [WARNING] [SETUP] This also disables the "Recently Closed Tabs" feature
 * It does not affect "Recently Closed Windows" or any history. ***/
user_pref("browser.sessionstore.max_tabs_undo", 100);
user_pref("browser.sessionstore.max_windows_undo", 10);
// 1021b: disable deferred level of storing extra session data 0=all 1=http-only 2=none
   // extra session data contains contents of forms, scrollbar positions, cookies and POST data
   // [-] https://bugzilla.mozilla.org/1235379
user_pref("browser.sessionstore.privacy_level_deferred", 0);
/* 2803: set what history items to clear on shutdown
 * [SETTING] Privacy & Security>History>Clear history when Firefox closes>Settings
 * [NOTE] If 'history' is true, downloads will also be cleared regardless of the value
 * but if 'history' is false, downloads can still be cleared independently
 * However, this may not always be the case. The interface combines and syncs these
 * prefs when set from there, and the sanitize code may change at any time ***/
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.downloads", true); // see note above
user_pref("privacy.clearOnShutdown.formdata", true); // Form & Search History
user_pref("privacy.clearOnShutdown.history", false); // Browsing & Download History
user_pref("privacy.clearOnShutdown.offlineApps", true); // Offline Website Data
user_pref("privacy.clearOnShutdown.sessions", false); // Active Logins
user_pref("privacy.clearOnShutdown.siteSettings", false); // Site Preferences
/* 2804: reset default history items to clear with Ctrl-Shift-Del (to match above)
 * This dialog can also be accessed from the menu History>Clear Recent History
 * Firefox remembers your last choices. This will reset them when you start Firefox.
 * [NOTE] Regardless of what you set privacy.cpd.downloads to, as soon as the dialog
 * for "Clear Recent History" is opened, it is synced to the same as 'history' ***/
user_pref("privacy.cpd.cache", true);
user_pref("privacy.cpd.cookies", false);
   // user_pref("privacy.cpd.downloads", true); // not used, see note above
user_pref("privacy.cpd.formdata", true); // Form & Search History
user_pref("privacy.cpd.history", false); // Browsing & Download History
user_pref("privacy.cpd.offlineApps", true); // Offline Website Data
user_pref("privacy.cpd.passwords", false); // this is not listed
user_pref("privacy.cpd.sessions", false); // Active Logins
user_pref("privacy.cpd.siteSettings", false); // Site Preferences
/* 4001: enable First Party Isolation (FF51+)
 * [WARNING] May break cross-domain logins and site functionality until perfected
 * [1] https://bugzilla.mozilla.org/1260931 ***/
user_pref("privacy.firstparty.isolate", false);

/*** 5000: PERSONAL [SETUP]
     Non-project related but useful. If any of these interest you, add them to your overrides ***/
user_pref("_user.js.parrot", "5000 syntax error: this is an ex-parrot!");
/* WELCOME & WHAT's NEW NOTICES ***/
   // user_pref("browser.startup.homepage_override.mstone", "ignore"); // master switch
   // user_pref("startup.homepage_welcome_url", "");
   // user_pref("startup.homepage_welcome_url.additional", "");
   // user_pref("startup.homepage_override_url", ""); // What's New page after updates
/* WARNINGS ***/
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("browser.tabs.warnOnOpen", false);
user_pref("full-screen-api.warning.delay", 0);
user_pref("full-screen-api.warning.timeout", 0);
/* APPEARANCE ***/
   // user_pref("browser.download.autohideButton", false); // (FF57+)
   // user_pref("toolkit.cosmeticAnimations.enabled", false); // (FF55+)
/* CONTENT BEHAVIOR ***/
   // user_pref("accessibility.typeaheadfind", true); // enable "Find As You Type"
   // user_pref("clipboard.autocopy", false); // disable autocopy default [LINUX]
user_pref("layout.spellcheckDefault", 2); // 0=none, 1-multi-line, 2=multi-line & single-line
/* UX BEHAVIOR ***/
user_pref("browser.backspace_action", 2); // 0=previous page, 1=scroll up, 2=do nothing
user_pref("browser.ctrlTab.previews", true);
user_pref("browser.tabs.closeWindowWithLastTab", false);
   // user_pref("browser.tabs.loadBookmarksInTabs", true); // open bookmarks in a new tab (FF57+)
   // user_pref("browser.urlbar.decodeURLsOnCopy", true); // see  Bugzilla 1320061 (FF53+)
   // user_pref("general.autoScroll", false); // middle-click enabling auto-scrolling [WINDOWS] [MAC]
   // user_pref("ui.key.menuAccessKey", 0); // disable alt key toggling the menu bar [RESTART]
/* OTHER ***/
   // user_pref("browser.bookmarks.max_backups", 2);
   // user_pref("identity.fxaccounts.enabled", false); // disable and hide Firefox Accounts and Sync (FF60+) [RESTART]
   // user_pref("network.manage-offline-status", false); // see Bugzilla 620472
   // user_pref("reader.parse-on-load.enabled", false); // "Reader View"
   // user_pref("xpinstall.signatures.required", false); // enforced extension signing (Nightly/ESR)
