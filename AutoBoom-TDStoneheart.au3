#RequireAdmin
$version = 20160204.00
#pragma compile(ProductVersion, 20160204.00)
#pragma compile(FileVersion, 2016.02.04.00)
#Region Metadata
#pragma compile(Icon, ca_104.ico)
#pragma compile(ExecLevel, requireAdministrator)
#pragma compile(UPX, true)
#pragma compile(Compression, 9)
#pragma compile(CompanyName, 'T.D. Stoneheart')
#pragma compile(FileDescription, 'Auto Boom – T.D. Stoneheart')
#pragma compile(InternalName, "AutoBoom-TDStoneheart")
#pragma compile(LegalCopyright, "© 2014–2015 T.D. Stoneheart")
#pragma compile(ProductName, 'Auto Boom – T.D. Stoneheart')
#pragma compile(AutoItExecuteAllowed, True)
#EndRegion Metadata
#Region Startup
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Crypt.au3>
#include <Debug.au3>
#include <String.au3>
;#include <Array.au3>
;Title: "◁~~~~Security~~~~Alert~~~~▷             "
;Class: "527746eb5277c15c00007a71                   "
;Title: "$------S-E-C-U-R-I-T-Y-------A-L-E-R-T-------$                                 "
;Class: "2c7f2df02c7fa1d4000073e4                                        "
;Text: "LOG" / "OK"
;XTC Multi 2.3: [No title]; Class: "Ta6"

Global Const $autoname = "Auto Boom – T.D. Stoneheart", $GUIHeight = 460 + (20 * 2) ;height+20 for each tab line!
Global Enum $AutoWho, $AutoNeedle, $AutoEXP, $AutoLadder, $AutoZombieWinMulti, $MiniAuto, $AutoMore
Global Enum $AutoMorePushStart, $AutoMoreQuestItem, $AutoMoreFishing, $AutoMoreMarket, $AutoMoreDice, $AutoMoreLose, _
		$AutoMoreLadderPushStart, $AutoMoreMarketMulti, $AutoMoreQuestItemMulti
Global Const $AutoWhoMode[] = ["Thường", "Sự kiện", "Zombie"], _
		$WinPoints[] = [173, 345, 690, 1155, 2145, 4950, 9405, 18810, 42000, 77910, 1E5], _
		$whatsnew = '* Hỗ trợ XTC Multi 2.3.' & @CRLF & '* Thêm chế độ TLT Zombie dành cho nhiều máy.'
Global $ActiveTab = 0, $CheckForUpdates = True, $DebugMode = True, $DebugModeFlag = True, $DefaultRoomName = "", _
		$pwd, $looptime, $ChannelName, $windows, $svrHN, $login, $w, $pl[199], $pass[199], $chanx = 513, $chany = 470, _
		$buffer, $LastNewWindow, $LastOldWindow, $LastActiveWindow, $autoloops, $whomode, $expmode, $ZombieMode[4], _
		$splashwindow, $ChannelName2, $MainGUI, $ChannelPage, $TownInChannel, $PressDelay, $timer, $wait, $WindowRenameResult, _
		$nexttimer, $LadderRandomizedMap, $download, $LadderWins, $mapchange, $HostWnd, $MoreMode, $FirstSwap, _
		$MarketCriterion, $MarketHotItems, $MarketPurpleText, $MarketPurchaseAlert, $MarketAnyItems, $NPCBugButton, $KellyNPCCheck, _
		$WindowNameInput[10], $LadderPushStartWindows, $LadderPushStartButton, $WhoModeSelect, $PeriodicCheck, $splashstatic, _
		$AutoWinButton, $AutoNeedleButton, $AutoEXPButton, $AutoLadderButton, $LadderCalc, $WindowRenameButton, _
		$TabSheetWin, $TabSheetNeedle, $TabSheetEXP, $TabSheetLadder, $TabSheetMiniAuto, $TabSheetMore, $InviteMode, _
		$groupname[5][$AutoMore], $player[9][$AutoMore], $password[9][$AutoMore], $SearchSpecific, $LevelSpinMode, _
		$loginusername, $loginpassword, $PermissionLicense, $localver = $version, $LoginButton, $HostMode, _
		$UserNameInput, $PasswordInput, $LoggedInStartup = False, $TabSheetZombieWinMulti, $AutoZombieWinButton
;$CheckForUpdates = False to disable auto-updating ;$DebugMode = False to disable debugging
;$ActiveTab changes default automation mode on startup ;$DefaultRoomName changes default room name as the automation runs
;WinMove("Boom", "", Random(0, @DesktopWidth - 1), Random(0, @DesktopHeight - 1), Default, Default, 5)
If Not IsAdmin() Then Exit (1 + MsgBox(16, $autoname, "Bạn phải chạy auto dưới quyền người quản trị để auto hoạt động."))
If @AutoItX64 Then Exit (2 + MsgBox(16, $autoname, "Bạn phải chạy auto trên bản 32-bit của AutoIt."))
AutoItSetOption("WinTitleMatchMode", 3) ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase
If WinExists($autoname) Then
	If MsgBox(48 + 1, $autoname, "Auto này đang chạy trên một cửa sổ khác." & @CRLF & _
			"Chú ý rằng sử dụng nhiều cửa sổ auto sẽ gây xung đột phím tắt." & @CRLF & _
			"Thông báo này sẽ đóng sau 10 giây." & @CRLF & @CRLF & _
			'Chọn "Hủy bỏ" để thoát cửa sổ auto này.', 10) = 2 Then Exit 5
EndIf
AutoItWinSetTitle($autoname)
ProgressOn($autoname, "Vui lòng chờ...", "Đang cài đặt dữ liệu ban đầu." & @CRLF & _
		"Lần chạy đầu tiên có thể mất nhiều thời gian.", -1, -1, 18)
ProcessSetPriority(@AutoItPID, 4)
AutoItSetOption("SendKeyDelay", 0)
AutoItSetOption("SendKeyDownDelay", 0)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2) ;1=absolute, 0=relative, 2=client
AutoItSetOption("TrayAutoPause", 0) ;0=no pause, 1=Pause
AutoItSetOption("TrayMenuMode", 1) ;0=append, 1=no default menu
AutoItSetOption("TrayOnEventMode", 1) ;0=disable, 1=enable
@Compiled ? FileDelete(@TempDir & '\AutoBoom-TDStoneheart-Copy.exe') : AutoItSetOption("TrayIconDebug", 1) ;0=no info, 1=debug line info
ProgressSet(20)
$path = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "CAPath")
Do
	If @error Then ExitLoop
	If FileExists($path & "\xtcmulti2.3.exe") Then ExitLoop
	If Not FileInstall("C:\XTC Multi\xtcmulti.exe", @ScriptDir & "\xtcmulti.exe", 0) Then ExitLoop
	Run(@ScriptDir & "\xtcmulti.exe", "", @SW_MINIMIZE)
	If @error Then ExitLoop
	While WinClose("[TITLE:Notice; CLASS:#32770]", "XTC Multi 2.")
		Sleep(100)
	WEnd
	If WinWait("[CLASS:Ta6]", "Hà Nội", 5) Then WinSetState("[CLASS:Ta6]", "Hà Nội", @SW_MINIMIZE)
Until 1
ProgressSet(40)
If FileInstall("C:\Windows\Fonts\StoneheartMono1258.fon", @WindowsDir & "\Fonts\StoneheartMono1258.fon", 0) Then _
		InstallFont(@WindowsDir & "\Fonts\StoneheartMono1258.fon", "Stoneheart Sans Mono CP1258")
$MonoFont = FileExists(@WindowsDir & "\Fonts\StoneheartMono1258.fon") ? "Stoneheart Sans Mono CP1258" : "Courier New"
ProgressSet(60)
HttpSetUserAgent("Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)")
ConfigFileRead()
If $CheckForUpdates Then _
		$download = InetGet("https://www.dropbox.com/s/yxsowdatao3uurw/AutoBoom-TDStoneheart.txt?dl=1", _
		@TempDir & "\AutoBoom-TDStoneheart.txt", 1, 1)
ProgressSet(80)
OnAutoItExitRegister("PowerResetState")
PowerKeepAlive()
AdlibRegister("PowerKeepAlive", 3E4)
FileChangeDir(@ScriptDir)
TrayCreateItem("Thoát khỏi auto")
TrayItemSetOnEvent(-1, "Out")
TraySetState(1)
ProgressSet(100)
HotKeySet("!^+m", "MusicWarning")
ProgressOff()
;LoginScreen()
If ($loginusername == 'tduyduc') Or Not @Compiled Then HotKeySet("!^+d", "ExecuteDebug")
(CommandLine(False)) ? RunAuto() : AutoMainGUI()
#EndRegion Startup

Func LoginScreen()
	AutoItSetOption("GUIOnEventMode", 1)
	$StartupLoginGUI = GUICreate($autoname, 280, 128)
	GUIFont()
	$SavedLogin = FileOpen("AutoBoom-TDStoneheart-UserLogin.txt", 256)
	If $SavedLogin <> -1 Then
		FileReadLine($SavedLogin)
		FileReadLine($SavedLogin)
		$loginusername = FileReadLine($SavedLogin)
		$loginpassword = StringEncrypt(False, FileReadLine($SavedLogin))
		FileClose($SavedLogin)
	EndIf
	GUICtrlCreateLabel("Vui lòng đăng nhập để sử dụng auto!", 8, 8, 260, 25)
	GUICtrlCreateLabel("Tài khoản", 8, 40, 92, 20)
	GUICtrlCreateLabel("Mật khẩu", 8, 68, 92, 20)
	$UserNameInput = GUICtrlCreateInput($loginusername, 112, 40, 150, 20)
	$PasswordInput = GUICtrlCreateInput($loginpassword, 112, 68, 150, 20, $ES_PASSWORD)
	$LoginButton = GUICtrlCreateButton("Đăng nhập", 72, 96, 145, 25, $BS_DEFPUSHBUTTON)
	GUISetOnEvent(-3, "Out")
	GUICtrlSetOnEvent($LoginButton, "LoginTry")
	GUISetState(@SW_SHOW, $StartupLoginGUI)
	While 1
		$loginusername = String(GUICtrlRead($UserNameInput))
		$loginpassword = String(GUICtrlRead($PasswordInput))
		GUIGetMsg()
		If $LoggedInStartup Then
			GUIDelete($StartupLoginGUI)
			Return AutoItSetOption("GUIOnEventMode", 0)
		EndIf
	WEnd
EndFunc

Func LoginTry()
	GUICtrlSetOnEvent($LoginButton, "")
	GUICtrlSetState($LoginButton, $GUI_DISABLE)
	GUICtrlSetData($LoginButton, "Đang đăng nhập...")
	$LoggedInStartup = StartupLogin($loginusername, $loginpassword)
	$LoggedInStartup ? MsgBox(64, $autoname, "Đăng nhập thành công!") : MsgBox(16, $autoname, "Sai tài khoản hoặc mật khẩu! Thử lại.")
	GUICtrlSetData($LoginButton, "Đăng nhập")
	Return GUICtrlSetState($LoginButton, $GUI_ENABLE)
EndFunc

Func StartupLogin($username, $password)
	Local $pass
	Do
		$pass = InetRead('http://tduyduc.wap.sh/users/' & $username & '.dat')
		If @extended And Not @error Then ExitLoop
		;$pass = InetRead('https://sites.google.com/site/autoboomtdstoneheart/' & $username & '.dat?attredirects=0&d=1')
		;If @extended And Not @error Then ExitLoop
		;MsgBox(0, String(Hex(_Crypt_HashData($password, $CALG_SHA1))), StringTrimLeft(BinaryToString($pass), 2))
	Until 0
	$pass = StringSplit(StringStripCR(BinaryToString($pass)), @LF, 2)
	If Not IsArray($pass) Then Return False
	$PermissionLicense = ((UBound($pass) > 1) ? $pass[1] : 0)
	Return (('0x' & Hex(_Crypt_HashData($password, $CALG_SHA1))) = $pass[0])
EndFunc

Func AutoMainGUI()
	HotKeySet("{f1}")
	HotKeySet("{f5}")
	HotKeySet("^{f5}")
	HotKeySet("^{f6}")
	HotKeySet("^{f7}")
	HotKeySet("^{f8}")
	HotKeySet("^{f9}")
	HotKeySet("^{f12}")
	HotKeySet("+{pause}")
	HotKeySet("!^d")
	HotKeySet("!^t")
	HotKeySet("!^n")
	HotKeySet("!^r")
	HotKeySet("!^a")
	For $c = 1 To 5
		HotKeySet("!^" & $c)
	Next
	ProgressOn($autoname, "Vui lòng chờ...", _
			"Đang nạp giao diện chọn auto.", -1, -1, 18)
	For $c = 1 To 198
		$pl[$c] = ""
		$pass[$c] = ""
	Next
	$autoloops = 0
	$LadderWins = 0
	$MainGUI = GUICreate($autoname, 320, $GUIHeight, -1, -1)
	GUIFont()
	$MonoFont = FileExists(@WindowsDir & "\Fonts\StoneheartMono1258.fon") ? "Stoneheart Sans Mono CP1258" : "Courier New"
	$AutoSelection = GUICtrlCreateTab(0, 0, 320, $GUIHeight, 0x0302)
	ProgressSet(11)

	#Region $MainGUI
	$TabSheetWin = GUICtrlCreateTabItem("Tỉ lệ thắng")
	$AutoWinSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoWin.txt", 256)
	If $AutoWinSavedLogin <> -1 Then
		FileReadLine($AutoWinSavedLogin)
		FileReadLine($AutoWinSavedLogin)
		$svrHN = FileReadLine($AutoWinSavedLogin)
		FileReadLine($AutoWinSavedLogin)
		For $c = 1 To 4
			$pl[2 * $c - 1] = FileReadLine($AutoWinSavedLogin)
			$temppassword = FileReadLine($AutoWinSavedLogin)
			$pass[2 * $c - 1] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
			$pl[2 * $c] = FileReadLine($AutoWinSavedLogin)
			$temppassword = FileReadLine($AutoWinSavedLogin)
			$pass[2 * $c] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
			FileReadLine($AutoWinSavedLogin)
		Next
		$whomode = FileReadLine($AutoWinSavedLogin)
		$InviteMode = FileReadLine($AutoWinSavedLogin)
		FileClose($AutoWinSavedLogin)
	EndIf
	$InsideRoomLoggedIn = GUICtrlCreateCheckbox("Đã đăng nhập", 24, 8, 100, 17)
	GUICtrlCreateLabel("Chế độ:", 137, 8, 60, 17)
	$WhoModeSelect = GUICtrlCreateCombo("", 197, 8, 100, 17, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
	Switch $whomode
		Case 1 To UBound($AutoWhoMode) - 1
		Case Else
			$whomode = 0
	EndSwitch
	$combo = ""
	For $i = 0 To UBound($AutoWhoMode) - 1
		$combo &= "|" & $AutoWhoMode[$i]
	Next
	GUICtrlSetData($WhoModeSelect, $combo, $AutoWhoMode[$whomode])
	GUILoginInput($AutoWho)
	$ServerHN = GUICtrlCreateCheckbox("Server Hà Nội", 24, 360, 100, 25)
	GUICtrlSetTip(-1, 'Chọn máy chủ đăng nhập.')
	Switch $svrHN
		Case 1, 4
			GUICtrlSetState(-1, $svrHN)
		Case Else
			GUICtrlSetState(-1, $GUI_CHECKED)
	EndSwitch
	$ChannelSelect = GUICtrlCreateCombo("", 130, 360, 100, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
	GUICtrlSetTip(-1, 'Chọn kênh đăng nhập.')
	GUIChannels($ServerHN, $ChannelSelect)
	$InModeSelect = GUICtrlCreateCheckbox("/in", 240, 360, 56, 25)
	GUICtrlSetTip(-1, 'Sử dụng câu lệnh "/in" thay cho "/who".', "Chế độ /in")
	Switch $InviteMode
		Case 1, 4
			GUICtrlSetState(-1, $InviteMode)
	EndSwitch
	$AutoWinInstructionsButton = GUICtrlCreateButton("Hướng dẫn", 16, 388, 94, 25)
	$AutoWinSaveButton = GUICtrlCreateButton("Lưu thông tin", 110, 388, 100, 25)
	GUIButtonCreate($AutoWho)
	GUICtrlCreateLabel("Auto cải tiến bởi T.D. Stoneheart, dựa trên auto+code của Tuấn Zynky && Hoa Tuyết.", 16, 415, 288, 33)
	GUICtrlCreateTabItem("")
	ProgressSet(22)

	$TabSheetNeedle = GUICtrlCreateTabItem("Điểm danh")
	$AutoNeedleSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoNeedle.txt", 256)
	If $AutoNeedleSavedLogin <> -1 Then
		$svrHN = FileReadLine($AutoNeedleSavedLogin, 3)
		$LevelSpinMode = FileReadLine($AutoNeedleSavedLogin)
		FileClose($AutoNeedleSavedLogin)
	EndIf
	GUICtrlCreateGroup("Thiết đặt auto điểm danh nhanh", 16, 12, 288, 75)
	GUICtrlCreateLabel("Số lần đăng nhập:", 24, 30, 120, 17)
	$LoginInput = GUICtrlCreateInput(0, 138, 30, 40, 20, 0x2002)
	GUICtrlCreateUpdown($LoginInput, 0xA0)
	GUICtrlSetLimit(-1, 99, 0)
	$ServerHN2 = GUICtrlCreateCheckbox("Server Hà Nội", 200, 30, 100, 17)
	GUICtrlSetTip(-1, 'Chọn máy chủ đăng nhập.')
	Switch $svrHN
		Case 1, 4
			GUICtrlSetState(-1, $svrHN)
		Case Else
			GUICtrlSetState(-1, $GUI_CHECKED)
	EndSwitch
	$ChannelSelect2 = GUICtrlCreateCombo("", 150, 55, 70, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
	GUICtrlSetTip(-1, 'Chọn kênh đăng nhập.')
	GUIChannels($ServerHN2, $ChannelSelect2)
	$LevelSpinCheck = GUICtrlCreateCheckbox("Level", 230, 55, 70, 25)
	GUICtrlSetTip(-1, 'Các lần đăng nhập 2 nhân vật sẽ được tự động chuyển đổi thành 2 lần đăng nhập 1 nhân vật.', _
			'Chỉ dành cho sự kiện "Tăng cấp siêu tốc"')
	Switch $LevelSpinMode
		Case 1, 4
			GUICtrlSetState(-1, $LevelSpinMode)
	EndSwitch
	GUIButtonCreate($AutoNeedle)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("Hướng dẫn", 16, 90, 288, 320)
	GUICtrlCreateLabel("" & _
			'* Auto hỗ trợ "điểm danh nhanh hằng ngày": đăng nhập, mua kim miễn phí, cho thú ăn và thoát. ' & @CRLF & _
			'(Ý tưởng cho thú ăn bởi Hùng Idol)' & @CRLF & _
			"* Tạo một cửa sổ Boom (không bắt buộc đổi tên) nhưng không bắt buộc phải tạo" & _
			(@Compiled ? "" : " nếu đã có XTC Multi 2.0") & "." & @CRLF & _
			"* Nhập số lần đăng nhập (tối đa 99 lần hay 198 nhân vật). " & _
			"Nhập 0 để chuyển nhập từ tệp đã lưu (không cần chọn máy chủ trước)." & @CRLF & _
			"* Nhập thông tin cho từng lần đăng nhập (có thể nhập 1 hoặc 2 nhân vật)." & @CRLF & _
			"* Auto sẽ bắt đầu từ màn hình đăng nhập. Nếu đang ở màn chơi hay một màn hình nào khác, " & _
			"auto sẽ tự đăng xuất để trở về màn hình đăng nhập." & @CRLF & _
			"* Nếu Boom bị ngắt kết nối khi vào cửa hàng, hãy trở về giao diện này và chọn một kênh khác." & @CRLF & _
			"* Auto có khả năng phục hồi đăng nhập khi bị ngắt kết nối.", 24, 105, 272, 300)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateLabel("Auto điểm danh nhanh được viết bởi T.D. Stoneheart.", 16, 415, 288, 33)
	GUICtrlCreateTabItem("")
	ProgressSet(33)

	$TabSheetEXP = GUICtrlCreateTabItem("EXP/Level")
	$AutoEXPSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoEXP.txt", 256)
	If $AutoEXPSavedLogin <> -1 Then
		FileReadLine($AutoEXPSavedLogin)
		FileReadLine($AutoEXPSavedLogin)
		$svrHN = FileReadLine($AutoEXPSavedLogin)
		FileReadLine($AutoEXPSavedLogin)
		For $c = 1 To 4
			$pl[100 + (2 * $c - 1)] = FileReadLine($AutoEXPSavedLogin)
			$temppassword = FileReadLine($AutoEXPSavedLogin)
			$pass[100 + (2 * $c - 1)] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
			$pl[100 + (2 * $c)] = FileReadLine($AutoEXPSavedLogin)
			$temppassword = FileReadLine($AutoEXPSavedLogin)
			$pass[100 + (2 * $c)] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
			FileReadLine($AutoEXPSavedLogin)
		Next
		$expmode = FileReadLine($AutoEXPSavedLogin, 25)
		FileClose($AutoEXPSavedLogin)
	EndIf
	GUIStartGroup($MainGUI)
	$ZombieMode[0] = GUICtrlCreateRadio("Nhà máy 01", 24, 8, 100, 20)
	$ZombieMode[1] = GUICtrlCreateRadio("Zombie (1)", 124, 8, 84, 20)
	$ZombieMode[2] = GUICtrlCreateRadio("(2)", 208, 8, 47, 20)
	$ZombieMode[3] = GUICtrlCreateRadio("(3)", 255, 8, 47, 20)
	For $i = 0 To UBound($ZombieMode) - 1
		GUICtrlSetTip($ZombieMode[$i], 'Chọn chế độ auto.')
	Next
	Switch $expmode
		Case 1 To 3
			GUICtrlSetState($ZombieMode[$expmode], $GUI_CHECKED)
		Case Else ;0
			GUICtrlSetState($ZombieMode[0], $GUI_CHECKED)
	EndSwitch
	GUIStartGroup($MainGUI)
	GUILoginInput($AutoEXP)
	$ServerHN3 = GUICtrlCreateCheckbox("Server HN", 24, 360, 75, 25)
	GUICtrlSetTip(-1, 'Chọn máy chủ đăng nhập.')
	Switch $svrHN
		Case 1, 4
			GUICtrlSetState(-1, $svrHN)
		Case Else
			GUICtrlSetState(-1, $GUI_CHECKED)
	EndSwitch
	$InsideRoomLoggedIn2 = GUICtrlCreateCheckbox("Đã đăng nhập", 110, 360, 100, 25)
	$ChannelSelect3 = GUICtrlCreateCombo("", 221, 360, 75, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
	GUICtrlSetTip(-1, 'Chọn kênh đăng nhập.')
	GUIChannels($ServerHN3, $ChannelSelect3)
	$AutoEXPInstructionsButton = GUICtrlCreateButton("Hướng dẫn", 16, 388, 94, 25)
	$AutoEXPSaveButton = GUICtrlCreateButton("Lưu thông tin", 110, 388, 100, 25)
	GUIButtonCreate($AutoEXP)
	GUICtrlCreateLabel("Auto cải tiến bởi T.D. Stoneheart, dựa trên code+auto EXP Nhà máy 01 của MomT2.", 16, 415, 288, 33)
	GUICtrlCreateTabItem("")
	ProgressSet(44)

	$TabSheetLadder = GUICtrlCreateTabItem("Siêu cấp")
	$AutoLadderSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoLadder.txt", 256)
	If $AutoLadderSavedLogin <> -1 Then
		FileReadLine($AutoLadderSavedLogin)
		FileReadLine($AutoLadderSavedLogin)
		$svrHN = FileReadLine($AutoLadderSavedLogin)
		For $c = 1 To 4
			FileReadLine($AutoLadderSavedLogin)
			$pl[10 + (2 * $c - 1)] = FileReadLine($AutoLadderSavedLogin)
			$temppassword = FileReadLine($AutoLadderSavedLogin)
			$pass[10 + (2 * $c - 1)] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
			$pl[10 + (2 * $c)] = FileReadLine($AutoLadderSavedLogin)
			$temppassword = FileReadLine($AutoLadderSavedLogin)
			$pass[10 + (2 * $c)] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
		Next
		;FileReadLine($AutoLadderSavedLogin)
		;$InviteMode = FileReadLine($AutoLadderSavedLogin)
		FileClose($AutoLadderSavedLogin)
	EndIf
	$InsideRoomLoggedIn3 = GUICtrlCreateCheckbox("Đã đăng nhập", 24, 8, 100, 17)
	$ServerHN4 = GUICtrlCreateCheckbox("Server Hà Nội", 200, 8, 100, 17)
	GUICtrlSetTip(-1, 'Chọn máy chủ đăng nhập.')
	Switch $svrHN
		Case 1, 4
			GUICtrlSetState(-1, $svrHN)
		Case Else
			GUICtrlSetState(-1, $GUI_CHECKED)
	EndSwitch
	#cs
	$InModeSelect2 = GUICtrlCreateCheckbox("/in", 250, 8, 44, 17)
	GUICtrlSetTip(-1, 'Sử dụng câu lệnh "/in" thay cho "/who".', "Chế độ /in")
	Switch $InviteMode
		Case 1, 4
			GUICtrlSetState(-1, $InviteMode)
	EndSwitch
	#ce
	GUILoginInput($AutoLadder)
	$ChannelSelect4_1 = GUICtrlCreateCombo("", 24, 360, 136, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
	GUICtrlSetTip(-1, 'Chọn kênh đăng nhập thứ nhất.')
	GUICtrlSetData(-1, LadderChannels(GUICtrlRead($ServerHN4)), "TD-02")
	$ChannelSelect4_2 = GUICtrlCreateCombo("", 160, 360, 136, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
	GUICtrlSetTip(-1, 'Chọn kênh đăng nhập thứ hai.')
	GUICtrlSetData(-1, LadderChannels(GUICtrlRead($ServerHN4)), "TD-04")
	$AutoLadderHelpButton = GUICtrlCreateButton("Hướng dẫn", 16, 388, 94, 25)
	$AutoLadderSaveButton = GUICtrlCreateButton("Lưu thông tin", 110, 388, 100, 25)
	GUIButtonCreate($AutoLadder)
	GUICtrlCreateLabel("Auto siêu cấp được viết bởi T.D. Stoneheart." & @CRLF & _
			"Chú ý: Đã ngừng hỗ trợ auto siêu cấp!", 16, 415, 288, 33)
	GUICtrlCreateTabItem("")
	ProgressSet(55)

	$TabSheetZombieWinMulti = GUICtrlCreateTabItem("TLT Zombie+")
	$AutoZombieWinSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoZombieWin.txt", 256)
	If $AutoZombieWinSavedLogin <> -1 Then
		FileReadLine($AutoZombieWinSavedLogin)
		FileReadLine($AutoZombieWinSavedLogin)
		$svrHN = FileReadLine($AutoZombieWinSavedLogin)
		FileReadLine($AutoZombieWinSavedLogin)
		For $c = 1 To 3
			$pl[20 + $c] = FileReadLine($AutoZombieWinSavedLogin)
			$temppassword = FileReadLine($AutoZombieWinSavedLogin)
			$pass[20 + $c] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
		Next
		FileReadLine($AutoZombieWinSavedLogin)
		$HostMode = FileReadLine($AutoZombieWinSavedLogin)
		FileClose($AutoZombieWinSavedLogin)
	EndIf
	GUICtrlCreateLabel("Vai trò khách/chủ: ", 24, 8, 100, 17)
	$HostModeCheck = GUICtrlCreateCheckbox("Chủ phòng", 200, 8, 100, 17)
	GUICtrlSetTip(-1, 'Bỏ đánh dấu để tham gia phòng của một chủ phòng đã định trước.', 'Chọn vai trò khách/chủ')
	Switch $HostMode
		Case 1, 4
			GUICtrlSetState(-1, $HostMode)
		Case Else
			GUICtrlSetState(-1, $GUI_CHECKED)
	EndSwitch
	GUILoginInput($AutoZombieWinMulti)
	$groupname[2][$AutoZombieWinMulti] = GUICtrlCreateGroup("Thông tin của chủ phòng", 24, 82 + 31, 272, 79)
	$player[3][$AutoZombieWinMulti] = GUICtrlCreateInput($pl[23], 190, 82 + 62, 98, 20)
	GUICtrlSetLimit(-1, 12)
	GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
	GUICtrlSetTip(-1, 'Tên nhân vật của chủ phòng sẽ được dùng trong câu lệnh "who" để vào phòng.')
	$password[3][$AutoZombieWinMulti] = GUICtrlCreateInput($pass[23], 190, 82 + 85, 98, 20, $ES_PASSWORD)
	GUICtrlSetLimit(-1, 8)
	GUICtrlSetFont(-1, 9, 0, 0, "Courier New")
	GUICtrlSetTip(-1, 'Mật khẩu được dùng để vào phòng của chủ phòng đã nhập, không phải mật khẩu nhân vật.')
	GUICtrlCreateLabel("Nhân vật chủ phòng", 32, 82 + 62, 150, 20)
	GUICtrlCreateLabel("Mật khẩu phòng", 32, 82 + 85, 150, 20)
	If GUICtrlRead($HostModeCheck) = 1 Then GUICtrlSetState($player[3][$AutoZombieWinMulti], 128)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$ServerHN5 = GUICtrlCreateCheckbox("Server HN", 24, 360, 75, 25)
	GUICtrlSetTip(-1, 'Chọn máy chủ đăng nhập.')
	Switch $svrHN
		Case 1, 4
			GUICtrlSetState(-1, $svrHN)
		Case Else
			GUICtrlSetState(-1, $GUI_CHECKED)
	EndSwitch
	$InsideRoomLoggedIn5 = GUICtrlCreateCheckbox("Đã đăng nhập", 110, 360, 100, 25)
	$ChannelSelect5 = GUICtrlCreateCombo("", 221, 360, 75, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
	GUICtrlSetTip(-1, 'Chọn kênh đăng nhập.')
	GUIChannels($ServerHN5, $ChannelSelect5)
	$AutoZombieWinHelpButton = GUICtrlCreateButton("Hướng dẫn", 16, 388, 94, 25)
	$AutoZombieWinSaveButton = GUICtrlCreateButton("Lưu thông tin", 110, 388, 100, 25)
	GUIButtonCreate($AutoZombieWinMulti)
	GUICtrlCreateLabel("Auto tỉ lệ thắng bằng chế độ Zombie dành cho nhiều máy được viết bởi T.D. Stoneheart.", 16, 415, 288, 33)
	GUICtrlCreateTabItem("")
	ProgressSet(66)

	$TabSheetMiniAuto = GUICtrlCreateTabItem("Mini-auto")
	GUICtrlCreateGroup('Nhập tên cửa sổ dùng mini-auto', 16, 15, 288, 180)
	If Not $HostWnd Then $HostWnd = "[CLASS:Crazy Arcade]"
	$HostWindowInput = GUICtrlCreateInput($HostWnd, 24, 35, 272, 25)
	$AutoPushStartButton = GUICtrlCreateButton("Auto chủ phòng", 24, 60, 126, 25)
	GUICtrlSetTip(-1, 'Tự động bấm nút bắt đầu khi mọi người chơi đã sẵn sàng.')
	$AutoQuestItemButton = GUICtrlCreateButton("Auto item nhiệm vụ", 150, 60, 146, 25)
	GUICtrlSetTip(-1, 'Tự động nhặt vật phẩm nhiệm vụ rơi từ máy bay.')
	$AutoFishingMode = GUICtrlCreateButton("Auto câu cá", 24, 85, 136, 25)
	GUICtrlSetTip(-1, 'Tự động câu cá ở quảng trường.')
	$AutoMarketMode = GUICtrlCreateButton("Auto chợ trời", 160, 85, 136, 25)
	GUICtrlSetTip(-1, 'Tự động mua đồ ở chợ trời với các yêu cầu nhất định.')
	$AutoLoseMode = GUICtrlCreateButton("Auto tỉ lệ sặc", 24, 110, 272, 25)
	GUICtrlSetTip(-1, 'Tăng tỉ lệ sặc cho các nhân vật tham gia auto.')
	$AutoDiceMode = GUICtrlCreateButton("Auto đảo báu vật (đổ xí ngầu)", 24, 135, 272, 25)
	GUICtrlSetTip(-1, 'Đổ xí ngầu liên tục chừng nào có khả năng (hỗ trợ 2P).', _
			'Chỉ dành cho sự kiện "Đảo báu vật"')
	$NPCBugMode = GUICtrlCreateButton("Bug NPC đấu trường quái vật", 60, 160, 200, 25)
	GUICtrlSetTip(-1, 'Tạo ra NPC Leo phiên bản dễ hơn để hỗ trợ lấy hạng SS.')
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup('Mini-auto sử dụng nhiều cửa sổ', 16, 305, 288, 105)
	GUICtrlCreateLabel("Số cửa sổ:", 24, 325, 70, 25)
	$LadderPushStartInput = GUICtrlCreateInput(2, 95, 325, 36, 25, 0x2002)
	Switch $LadderPushStartWindows
		Case 1 To 9
			GUICtrlSetData(-1, $LadderPushStartWindows)
	EndSwitch
	GUICtrlCreateUpdown(-1, 0xA0)
	GUICtrlSetLimit(-1, 9, 1)
	$LadderPushStartMode = GUICtrlCreateButton("Hỗ trợ siêu cấp", 146, 325, 150, 25)
	GUICtrlSetTip(-1, 'Bấm nút bắt đầu gần như đồng thời trên các cửa sổ cụ thể.')
	$AutoMarketMultiMode = GUICtrlCreateButton("Auto chợ trời (nhiều cửa sổ)", 24, 350, 272, 25)
	GUICtrlSetTip(-1, 'Phiên bản này chậm hơn auto chợ trời dành cho một cửa sổ, ' & @CRLF & _
			'nhưng bạn có thể thu nhỏ các cửa sổ Boom trong khi auto chạy.')
	$AutoQuestItemMultiButton = GUICtrlCreateButton("Auto vật phẩm nhiệm vụ (nhiều cửa sổ)", 24, 375, 272, 25)
	GUICtrlSetTip(-1, 'Chậm hơn auto vật phẩm nhiệm vụ cho một cửa sổ, ' & @CRLF & _
			'nhưng có thể dùng cho nhiều cửa sổ đồng thời.')
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUIButtonCreate($MiniAuto)
	GUICtrlCreateTabItem("")
	ProgressSet(77)

	$TabSheetMore = GUICtrlCreateTabItem("Khác")
	GUICtrlCreateGroup("Công cụ cửa sổ", 16, 10, 288, 200)
	GUICtrlCreateLabel("Tên cửa sổ hiện tại:", 24, 30, 200, 20)
	$ClearOldWindow = GUICtrlCreateButton("Xoá", 246, 30, 50, 20)
	$OldWindow = GUICtrlCreateInput("[TITLE:Boom; CLASS:Crazy Arcade]", 24, 50, 272, 25)
	GUICtrlCreateLabel("Tên cửa sổ mới:", 24, 80, 200, 20)
	$ClearNewWindow = GUICtrlCreateButton("Xoá", 246, 80, 50, 20)
	$NewWindow = GUICtrlCreateInput("b", 24, 100, 272, 25)
	$WindowRenameResult = GUICtrlCreateLabel('Nhập tên cửa sổ hiện tại và chọn lệnh tương ứng.', 24, 130, 288, 20)
	GUIButtonCreate($AutoMore)
	$UndoRenameButton = GUICtrlCreateButton("Hoàn tác đổi tên", 94, 150, 111, 25)
	$WindowShowButton = GUICtrlCreateButton("Hiện", 205, 150, 50, 25)
	$WindowHideButton = GUICtrlCreateButton("Ẩn", 255, 150, 41, 25)
	$WindowTransparencySlider = GUICtrlCreateSlider(24, 180, 272, 25, 0)
	GUICtrlSetLimit(-1, 255, 0)
	GUICtrlSetData(-1, 255)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("Thiết đặt tên phòng mặc định", 16, 215, 288, 45)
	$RoomNameInput = GUICtrlCreateInput($DefaultRoomName, 24, 235, 272, 20)
	GUICtrlSetLimit(-1, 22)
	GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("Cập nhật auto", 16, 265, 288, 65)
	$CheckForUpdatesCheck = GUICtrlCreateCheckbox("Kiểm tra cập nhật khi khởi động auto", 24, 285, 272, 25)
	GUICtrlSetTip(-1, 'Bạn nên bật chức năng này để nhận các bản sửa lỗi nhanh hơn.')
	GUICtrlSetState(-1, $CheckForUpdates ? 1 : 4)
	$DownloadStatus = GUICtrlCreateLabel($CheckForUpdates ? "Đang kiểm tra bản cập nhật..." : "", 24, 310, 272, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("Ghi thông tin báo cáo lỗi", 16, 335, 288, 50)
	$DebugModeCheck = GUICtrlCreateCheckbox("Kích hoạt", 24, 355, 100, 25)
	GUICtrlSetState(-1, $DebugMode ? 1 : 4)
	$DebugModeFlagCheck = GUICtrlCreateCheckbox("Lưu vào tệp", 184, 355, 100, 25)
	GUICtrlSetTip(-1, 'Nếu bật, tệp "AutoBoom-TDStoneheart-Debug.log" sẽ được tạo ở thư mục chứa auto. ' & @CRLF & _
			'Nếu tắt, thông tin báo cáo lỗi sẽ xuất hiện trên một cửa sổ Notepad.')
	GUICtrlSetState(-1, $DebugModeFlag ? 1 : 4)
	GUICtrlSetState($DebugModeFlagCheck, (GUICtrlRead($DebugModeCheck) = 1) ? $GUI_ENABLE : $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$CommonHelpButton = GUICtrlCreateButton("Hướng dẫn chung cho auto", 60, 388, 200, 25)
	GUICtrlCreateLabel("www.facebook.com/tduyduc" & @CRLF & "AutoBoom-TDStoneheart  " & _
			StringFormat("%.2f", $version) & "/" & StringUpper(StringRight(@ScriptName, 3)), 16, 415, 288, 33, $SS_CENTER)
	If FileExists(@WindowsDir & "\Fonts\StoneheartMono1258.fon") Then GUICtrlSetFont(-1, 9, 0, 0, "Stoneheart Sans Mono CP1258")
	GUICtrlSetTip(-1, 'Thông tin phiên bản của auto.')
	GUICtrlCreateTabItem("")
	ProgressSet(88)
	#EndRegion $MainGUI

	For $i = $AutoWho To $AutoZombieWinMulti
		GroupRename($i)
	Next
	DefaultPushButtonByTab()
	ProgressOff()
	If ($localver < $version) And $whatsnew Then _
			MsgBox(64, $autoname, "Tính năng mới trong phiên bản " & _
			StringFormat("%.2f", $version) & ":" & @CRLF & @CRLF & $whatsnew)
	WinSetTrans($MainGUI, "", 0)
	GUISetState(@SW_SHOW, $MainGUI)
	$bufferwindow = WinGetPos($MainGUI)
	If Not @error Then
		$bufferclient = WinGetClientSize($MainGUI)
		$buffer = @error ? 0 : ($bufferwindow[2] - $bufferclient[0]) ;buffer width
	EndIf
	WinFade($MainGUI, "", 0, 225, 25)

	While 1
		If InetGetInfo($download, 2) Then ;automatic update
			Do
				If Not InetGetInfo($download, 3) Then
					GUICtrlSetData($DownloadStatus, "Không thể kiểm tra bản cập nhật.")
					ExitLoop
				EndIf
				$UpdateCheck = FileOpen(@TempDir & "\AutoBoom-TDStoneheart.txt", 256)
				If $UpdateCheck = -1 Then
					GUICtrlSetData($DownloadStatus, "Không thể cập nhật.")
					ExitLoop
				EndIf
				$RemoteVersion = Number(StringTrimLeft(FileReadLine($UpdateCheck, 1), 9))
				FileClose($UpdateCheck)
				GUICtrlSetData($DownloadStatus, "Phiên bản mới nhất: " & StringFormat("%.2f", $RemoteVersion))
				If $RemoteVersion <= $version Then ExitLoop
				If MsgBox(4 + 32, "Có phiên bản mới", _
						"Phiên bản hiện tại: " & StringFormat("%.2f", $version) & @CRLF & _
						"Phiên bản mới: " & StringFormat("%.2f", $RemoteVersion) & @CRLF & _
						"Bạn có muốn cập nhật phiên bản mới không?") = 7 Then ExitLoop
				FileDelete(@TempDir & "\AutoBoom-TDStoneheart.txt")
				FileDelete(@TempDir & "\AutoBoom-TDStoneheart-Update.txt")
				$AutoUpdate = FileOpen(@TempDir & "\AutoBoom-TDStoneheart-Update.txt", 256 + 2)
				If $AutoUpdate = -1 Then
					MsgBox(48, "Không thể cập nhật", "Vui lòng cập nhật thủ công.")
					ExitLoop
				EndIf
				FileWriteLine($AutoUpdate, @AutoItPID)
				FileWriteLine($AutoUpdate, @ScriptFullPath)
				If Not (FileFlush($AutoUpdate)) Then
					MsgBox(48, "Không thể cập nhật", "Vui lòng cập nhật thủ công.")
					ExitLoop
				EndIf
				FileClose($AutoUpdate)
				FileDelete(@TempDir & "\AutoBoom-TDStoneheart-Update.au3")
				$AutoUpdate = FileOpen(@TempDir & "\AutoBoom-TDStoneheart-Update.au3", 256 + 2)
				If $AutoUpdate = -1 Then
					MsgBox(48, "Không thể cập nhật", "Vui lòng cập nhật thủ công.")
					ExitLoop
				EndIf
				FileWriteLine($AutoUpdate, '$update = FileOpen(@TempDir & "\AutoBoom-TDStoneheart-Update.txt", 256)')
				FileWriteLine($AutoUpdate, 'ProcessClose(Number(FileReadLine($update, 1)))')
				FileWriteLine($AutoUpdate, '$autopath = FileReadLine($update, 2)')
				FileWriteLine($AutoUpdate, '$extension = StringRight(FileReadLine($update, 2), 4)')
				FileWriteLine($AutoUpdate, 'ProcessWaitClose(FileReadLine($update, 1))')
				FileWriteLine($AutoUpdate, 'FileMove($autopath, @TempDir & "\AutoBoom-TDStoneheart.old", 1)')
				FileWriteLine($AutoUpdate, 'FileClose($update)')
				FileWriteLine($AutoUpdate, 'If FileMove(@TempDir & "\AutoBoom-TDStoneheart" & $extension, $autopath, 1) Then')
				FileWriteLine($AutoUpdate, ' FileDelete(@TempDir & "\AutoBoom-TDStoneheart.old")')
				FileWriteLine($AutoUpdate, ' MsgBox(0, "Thành công", "Đã cập nhật xong. Hãy chạy lại auto.")')
				FileWriteLine($AutoUpdate, 'Else')
				FileWriteLine($AutoUpdate, ' FileMove(@TempDir & "\AutoBoom-TDStoneheart.old", $autopath, 1)')
				FileWriteLine($AutoUpdate, ' MsgBox(0, "Thất bại", "Không thể cập nhật. Hãy chạy lại auto.")')
				FileWriteLine($AutoUpdate, 'EndIf')
				FileWriteLine($AutoUpdate, 'FileDelete(@TempDir & "\AutoBoom-TDStoneheart-Update.txt")')
				If Not FileFlush($AutoUpdate) Then
					MsgBox(48, "Không thể cập nhật", "Vui lòng cập nhật thủ công.")
					ExitLoop
				EndIf
				InetClose($download)
				FileDelete(@TempDir & "\AutoBoom-TDStoneheart.txt")
				WinFade($MainGUI, "", 225, 0, -25)
				GUIDelete($MainGUI)
				ProgressOn($autoname, "Đang tải bản cập nhật...", @AutoItPID & @ScriptFullPath, -1, -1, 18)
				$hWnd = WinGetHandle($autoname, @AutoItPID & @ScriptFullPath)
				ProgressSet(0, _
						"Phiên bản hiện tại: " & StringFormat("%.2f", $version) & @CRLF & _
						"Phiên bản mới: " & StringFormat("%.2f", $RemoteVersion) & @CRLF & _
						"Alt+F4: Huỷ bỏ && thoát")
				If Not @Compiled Then
					$remotefile = "https://www.dropbox.com/s/nzw32go6vk93w45/AutoBoom-TDStoneheart.au3?dl=1"
					$localfile = @TempDir & "\AutoBoom-TDStoneheart.au3"
				ElseIf StringUpper(StringRight(@ScriptFullPath, 4)) = ".EXE" Then
					$remotefile = "https://www.dropbox.com/s/x97800pvox0vod4/AutoBoom-TDStoneheart.exe?dl=1"
					$localfile = @TempDir & "\AutoBoom-TDStoneheart.exe"
				Else
					$remotefile = "https://www.dropbox.com/s/r70bqmcx8zvmu4t/AutoBoom-TDStoneheart.a3x?dl=1"
					$localfile = @TempDir & "\AutoBoom-TDStoneheart.a3x"
				EndIf
				$NewUpdate = InetGet($remotefile, $localfile, 1, 1)
				$DownloadSize = InetGetSize($remotefile, 1)
				Do
					Sleep(10)
					ProgressSet(Round((InetGetInfo($NewUpdate, 0) / $DownloadSize) * 100))
					If Not WinExists($hWnd) Then Exit _
							(3 + MsgBox(48, "Huỷ cập nhật", "Bạn đã huỷ bỏ quá trình cập nhật." _
							& @CRLF & "Bấm OK để thoát khỏi auto."))
				Until InetGetInfo($NewUpdate, 2)
				ProgressOff()
				If @Compiled And StringUpper(StringRight(@ScriptFullPath, 4)) = ".EXE" Then
					$exe = @TempDir & '\AutoBoom-TDStoneheart-Copy.exe'
					FileCopy(@AutoItExe, $exe)
				Else
					$exe = @AutoItExe
				EndIf
				If InetGetInfo($NewUpdate, 4) Then
					InetClose($NewUpdate)
					MsgBox(48, "Không thể cập nhật", "Tải bản cập nhật thất bại.")
					Return AutoMainGUI()
				Else
					InetClose($NewUpdate)
					Run('"' & $exe & '" /AutoIt3ExecuteScript "' & @TempDir & '\AutoBoom-TDStoneheart-Update.au3"')
					Exit 0
				EndIf
			Until 1
			InetClose($download)
			FileDelete(@TempDir & "\AutoBoom-TDStoneheart.txt")
		EndIf
		$DefaultRoomName = (GUICtrlRead($RoomNameInput) ? GUICtrlRead($RoomNameInput) : " ")
		$DebugMode = (GUICtrlRead($DebugModeCheck) = 1)
		If $DebugMode Then $DebugModeFlag = (GUICtrlRead($DebugModeFlagCheck) = 1)
		$CheckForUpdates = (GUICtrlRead($CheckForUpdatesCheck) = 1)
		$GUIMsg = GUIGetMsg()
		Switch $GUIMsg
			Case -3 ;$GUI_EVENT_CLOSE
				WinFade($MainGUI, "", 225, 0, -5)
				OnExit()
				Exit
			Case $AutoSelection
				$ActiveTab = GUICtrlRead($AutoSelection)
				DefaultPushButtonByTab()
			Case $CommonHelpButton
				CreateHelpGUI('Yêu cầu chung cho chế độ chưa đăng nhập (bỏ đánh dấu "Đã đăng nhập"):' & @CRLF & _
						(@Compiled ? "" : ('* Yêu cầu đã cài đặt XTC Multi 2.0 để mở cửa sổ mới.' & @CRLF)) & _
						"* Nhập thông tin đăng nhập cho mỗi cửa sổ (mang nhân vật chính/phụ theo hướng dẫn)." & @CRLF & _
						"* Auto sẽ tự tạo và đổi tên cửa sổ rồi đăng nhập theo yêu cầu và chuyển sang tiến hành auto như chế độ đã đăng nhập." _
						 & @CRLF & @CRLF & _
						"Hướng dẫn chung cho auto:" & @CRLF & _
						'* Nếu chạy auto với chế độ đã đăng nhập, hãy nhập dãy kí tự bất kì vào phần thông tin đăng nhập của ' & _
						'nhân vật và cửa sổ tương ứng mà bạn đang đăng nhập để làm mặt nạ. (Ví dụ, nếu bạn đăng nhập 2P cho "b1", 1P cho "b2", ' & _
						'hãy nhập dãy kí tự bất kì vào ô nhân vật và mật khẩu của 1P & 2P trong khung "b1", của 1P trong khung "b2".) ' & _
						'Tuy nhiên, khi có thể, bạn nên nhập thông tin đúng để auto có thể đăng nhập lại nếu bị ngắt kết nối.' & @CRLF & _
						'* Khi nhập thông tin đăng nhập cho duy nhất một nhân vật, chỉ nhập vào các ô của cột 1P.' & @CRLF & _
						'* Có thể sử dụng tên nhân vật tiếng Việt có dấu, với điều kiện khi nhập sử dụng bảng mã "Vietnamese locale CP1258".' & @CRLF & _
						'* Tên nhân vật tiếng Việt có dấu có thể không hiển thị đúng khi nhập vào giao diện auto, ' & _
						'nhưng sẽ được nhập đúng vào Boom.' & @CRLF & _
						'* Phông chữ "Stoneheart Sans Mono CP1258" (đi kèm theo bản EXE/A3X) ' & _
						'có thể khắc phục tạm thời vấn đề hiển thị (chú ý chữ cái không liền dấu thanh). ' & _
						'(Chú ý tắt gõ tiếng Việt khi chạy auto!)' & @CRLF & _
						'* Thông tin đăng nhập khi lưu lại (để truy xuất nhanh cho các lần chạy auto tiếp theo) ' & _
						'sẽ được lưu trữ vào tệp văn bản thuần (có đặt trạng thái ẩn) ' & _
						'nằm ở cùng thư mục chứa auto. Chú ý rằng các mật khẩu đã lưu sẽ được mã hoá (không đọc được) khi mở các tệp này.' & @CRLF & _
						'* Chú ý khi lựa chọn kênh đăng nhập để tránh chọn phải kênh đầy người hoặc gây ngắt kết nối.' & @CRLF & _
						'* Auto chủ phòng có thể hỗ trợ việc treo cửa sổ khi thực hiện nhiệm vụ bằng cách tự động nhấn phím bắt đầu. ' & _
						'Nếu đang mở nhiều cửa sổ Boom, nên đổi tên cửa sổ chủ phòng để auto có thể phân biệt cửa sổ.' & @CRLF & _
						'* Auto vật phẩm nhiệm vụ hỗ trợ việc nhặt vật phẩm yêu cầu cho các nhiệm vụ nhất định được thả rơi từ máy bay. ' & _
						'Người chơi điều khiển phím mũi tên sẽ nhặt vật phẩm. ' & _
						'Yêu cầu cửa sổ được sử dụng là chủ phòng và phòng chứa ít nhất 2 nhân vật.' & @CRLF & _
						'* Khi nhập tên cửa sổ cho một số auto, bạn có thể nhập "[CLASS:Crazy Arcade]" (có thể sao chép ngay, không có dấu ' & _
						'ngoặc kép) để chọn một cửa sổ Boom với tên bất kì. Trong trường hợp này, chỉ nên mở một cửa sổ Boom duy nhất.' & @CRLF & _
						'* Các tổ hợp phím chung: Ctrl+F7: Tạm dừng auto; Ctrl+F9: Thoát khỏi auto.' & @CRLF & _
						'* Auto sẽ tự động vô hiệu hoá các chế độ tiết kiệm năng lượng (ví dụ tắt màn hình) khi chạy và sẽ phục hồi trạng thái cũ ' & _
						'khi thoát. Nếu các chế độ tiết kiệm năng lượng vẫn không hoạt động sau khi thoát auto, hãy mở auto rồi thoát ra hoặc ' & _
						'khởi động lại máy tính.' & @CRLF & _
						'* Thêm tham số dòng lệnh "/shortcut" khi mở auto để xem lối tắt chạy auto nhanh bằng dòng lệnh. ' & _
						'Thông tin này sẽ hiển thị trước khi auto chạy.' & @CRLF & _
						'* Khi đang tiến hành chạy auto, có thể sử dụng phím Shift+Pause/Break để chặn (vô hiệu hoá) chuột và bàn phím, ' & _
						'không cho con trỏ chuột di chuyển hay nhập từ bàn phím. ' & _
						'Dùng tổ hợp phím Ctrl+Alt+Delete để ngừng chặn chuột và bàn phím.' & @CRLF & @CRLF & _
						'Dùng phím Esc hoặc nút đóng để trở về giao diện chọn auto.')
			Case $ServerHN, $ServerHN2, $ServerHN3, $ServerHN5
				$combo = Null
				Switch $GUIMsg
					Case $ServerHN
						$combo = $ChannelSelect
					Case $ServerHN2
						$combo = $ChannelSelect2
					Case $ServerHN3
						$combo = $ChannelSelect3
					Case $ServerHN5
						$combo = $ChannelSelect5
				EndSwitch
				GUIChannels($GUIMsg, $combo)
			Case $LadderCalc
				WinFade($MainGUI, "", 225, 0, -25)
				GUIDelete($MainGUI)
				$LadderWPCalc = GUICreate("Tính điểm siêu cấp", 320, 180)
				GUIFont()
				GUICtrlCreateGroup("Điểm hiện tại", 24, 12, 272, 55)
				GUICtrlCreateLabel("Cấp", 37, 33, 50, 25)
				$combo = ""
				For $i = 0 To UBound($WinPoints) - 1
					$combo &= "|" & $i
				Next
				$GradeCombo = GUICtrlCreateCombo("", 75, 33, 58, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_DROPDOWNLIST, $WS_VSCROLL))
				GUICtrlSetData(-1, $combo, 0)
				GUICtrlCreateLabel("WP", 177, 33, 30, 25)
				$WPInput = GUICtrlCreateInput(0, 213, 33, 65, 25, 0x2002)
				GUICtrlSetLimit(-1, 5)
				$WPUpdown = GUICtrlCreateUpdown($WPInput, 0xA0)
				GUICtrlCreateGroup("", -99, -99, 1, 1)
				GUICtrlCreateGroup("Điểm tối đa trong ngày (+1999 WP)", 24, 76, 272, 55)
				GUICtrlCreateLabel("Cấp", 37, 97, 50, 25)
				$NextGradeOutput = GUICtrlCreateInput("", 75, 97, 58, 25, 0x2802)
				GUICtrlCreateLabel("WP", 177, 97, 30, 25)
				$NextWPOutput = GUICtrlCreateInput("", 213, 97, 65, 25, 0x2802)
				$WPTableButton = GUICtrlCreateButton("Bảng điểm siêu cấp chi tiết", 24, 140, 273, 25)
				WinSetTrans($LadderWPCalc, "", 0)
				GUISetState(@SW_SHOW, $LadderWPCalc)
				WinFade($LadderWPCalc, "", 0, 225, 25)
				Local $LastGrade = -1, $LastWP = -1
				Do
					If $LastGrade <> Number(GUICtrlRead($GradeCombo)) Or $LastWP <> Number(GUICtrlRead($WPInput)) Then
						$MaximumPoints = $WinPoints[Number(GUICtrlRead($GradeCombo))] - 1
						If Number(GUICtrlRead($WPInput)) > $MaximumPoints Then GUICtrlSetData($WPInput, $MaximumPoints)
						GUICtrlSetLimit($WPUpdown, $MaximumPoints)
						$NextGrade = Number(GUICtrlRead($GradeCombo))
						$NextWP = Number(GUICtrlRead($WPInput)) + 1999
						While $NextWP > $WinPoints[$NextGrade] - 1 And $NextGrade < UBound($WinPoints) - 1
							$NextWP -= $WinPoints[$NextGrade]
							$NextGrade += 1
						WEnd
						GUICtrlSetData($NextGradeOutput, $NextGrade)
						GUICtrlSetData($NextWPOutput, $NextWP)
						$LastGrade = Number(GUICtrlRead($GradeCombo))
						$LastWP = Number(GUICtrlRead($WPInput))
					EndIf
					Switch GUIGetMsg()
						Case -3
							WinFade($LadderWPCalc, "", 225, 0, -25)
							GUIDelete($LadderWPCalc)
							Return AutoMainGUI()
						Case $WPTableButton
							$WPTable = GUICreate("Điểm siêu cấp", 240, 240, -1, -1, -1, -1, $LadderWPCalc)
							GUIFont()
							GUICtrlCreateLabel("Điểm thắng cần đạt để lên hạng:", 16, 12, 140, 32)
							$WPTableDoneButton = GUICtrlCreateButton("OK", 160, 12, 64, 32, $BS_DEFPUSHBUTTON)
							$WPList = GUICtrlCreateEdit("Grade   WP" & @CRLF, 16, 50, 208, 180, 0x00200804)
							GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
							For $c = 0 To UBound($WinPoints) - 2
								If $c < 9 Then GUICtrlSetData($WPList, Chr(160), 1)
								GUICtrlSetData($WPList, $c + 1, 1)
								For $i = 1 To 8 - StringLen($WinPoints[$c])
									GUICtrlSetData($WPList, Chr(160), 1)
								Next
								GUICtrlSetData($WPList, $WinPoints[$c] & @CRLF, 1)
							Next
							WinSetTrans($WPTable, "", 0)
							GUISetState(@SW_SHOW, $WPTable)
							WinFade($WPTable, "", 0, 225, 25)
							While 1
								Switch GUIGetMsg()
									Case $WPTableDoneButton, $GUI_EVENT_CLOSE
										WinFade($WPTable, "", 225, 0, -25)
										GUIDelete($WPTable)
										ExitLoop
								EndSwitch
							WEnd
					EndSwitch
				Until 0
			Case $AutoPushStartButton, $AutoQuestItemButton, $AutoFishingMode, $AutoMarketMode, $AutoDiceMode, $NPCBugMode, $AutoLoseMode
				$ActiveTab = $MiniAuto
				Switch $GUIMsg
					Case $AutoPushStartButton
						$MoreMode = $AutoMorePushStart
					Case $AutoQuestItemButton
						$MoreMode = $AutoMoreQuestItem
					Case $AutoFishingMode
						$MoreMode = $AutoMoreFishing
					Case $AutoMarketMode
						$MoreMode = $AutoMoreMarket
					Case $AutoDiceMode
						$MoreMode = $AutoMoreDice
					Case $AutoLoseMode
						$MoreMode = $AutoMoreLose
				EndSwitch
				$HostWnd = GUICtrlRead($HostWindowInput)
				WinFade($MainGUI, "", 225, 0, -25)
				GUIDelete($MainGUI)
				If Not WinExists($HostWnd) Or Not $HostWnd Then _
						MsgBox(48, $HostWnd ? "Cửa sổ không tồn tại" : "Chưa nhập tên cửa sổ", _
						"Auto sẽ chạy trên cửa sổ đang được kích hoạt.")
				If Not WinExists($HostWnd) Then $HostWnd = ""
				Switch $GUIMsg
					Case $NPCBugMode
						$NPCBugGUI = GUICreate("Bug NPC đấu trường quái vật", 320, 150)
						GUIFont()
						GUICtrlCreateLabel('* Bug thực hiện dễ nhất đối với mạng chậm (lag).' & @CRLF & _
								'* Yêu cầu nhân vật 1P của cửa sổ dùng auto phải có khả năng chọn NPC Leo.' & @CRLF & _
								'* Tạo phòng chơi đấu trường quái vật (có thể cho người khác vào) và chạy auto.' & @CRLF & _
								((WinExists($HostWnd) And $HostWnd) ? ('* Cửa sổ dùng auto: ' & $HostWnd) : _
								'* Kích hoạt cửa sổ Boom trước khi dùng phím tắt.'), 16, 8, 288, 95)
						$KellyNPCCheck = GUICtrlCreateCheckbox("Chọn NPC Kelly", 16, 115, 125, 25)
						GUICtrlSetState(-1, $GUI_CHECKED)
						$NPCBugButton = GUICtrlCreateButton("Thực hiện bug (F6)", 141, 115, 163, 25, $BS_DEFPUSHBUTTON)
						If Not (WinExists($HostWnd) And $HostWnd) Then GUICtrlSetState(-1, $GUI_DISABLE)
						HotKeySet("{f6}", "NPCBug")
						WinSetTrans($NPCBugGUI, "", 0)
						GUISetState(@SW_SHOW, $NPCBugGUI)
						WinFade($NPCBugGUI, "", 0, 225, 25)
						Do
							Switch GUIGetMsg()
								Case -3
									HotKeySet("{f6}")
									WinFade($NPCBugGUI, "", 225, 0, -25)
									GUIDelete($NPCBugGUI)
									Return AutoMainGUI()
								Case $NPCBugButton
									NPCBug()
							EndSwitch
						Until 0
					Case $AutoFishingMode, $AutoMarketMode
						Return AutoMarketGUI()
					Case Else
						Return PrepareForAuto()
				EndSwitch
			Case $LadderPushStartMode, $AutoMarketMultiMode, $AutoQuestItemMultiButton
				$LadderPushStartWindows = GUICtrlRead($LadderPushStartInput)
				WinFade($MainGUI, "", 225, 0, -25)
				GUIDelete($MainGUI)
				Switch $GUIMsg
					Case $LadderPushStartMode
						$MoreMode = $AutoMoreLadderPushStart
					Case $AutoMarketMultiMode
						$MoreMode = $AutoMoreMarketMulti
					Case $AutoQuestItemMultiButton
						$MoreMode = $AutoMoreQuestItemMulti
				EndSwitch
				Return AutoMarketGUI()
			Case $DebugModeCheck
				GUICtrlSetState($DebugModeFlagCheck, (GUICtrlRead($DebugModeCheck) = 1) ? $GUI_ENABLE : $GUI_DISABLE)
			Case $WindowTransparencySlider
				GUICtrlSetData($WindowRenameResult, WinSetTrans(GUICtrlRead($OldWindow), "", GUICtrlRead($WindowTransparencySlider)) ? _
						'Độ trong suốt: ' & StringFormat("%03i", GUICtrlRead($WindowTransparencySlider)) & "/255" : _
						"Không thể điều chỉnh độ trong suốt.")
			Case $WindowHideButton
				GUICtrlSetData($WindowRenameResult, WinGetHandle(GUICtrlRead($OldWindow)) = $MainGUI ? "Không thể ẩn chính cửa sổ này!" : _
						(WinSetState(GUICtrlRead($OldWindow), "", @SW_HIDE) ? "Đã ẩn cửa sổ." : "Không tìm thấy cửa sổ với tên đã nhập."))
			Case $WindowShowButton
				GUICtrlSetData($WindowRenameResult, WinSetState(GUICtrlRead($OldWindow), "", @SW_SHOW) _
						? "Đã hiện cửa sổ." : "Không tìm thấy cửa sổ với tên đã nhập.")
			Case $ClearOldWindow
				GUICtrlSetData($OldWindow, "")
				GUICtrlSetState($OldWindow, 256)
			Case $ClearNewWindow
				GUICtrlSetData($NewWindow, "")
				GUICtrlSetState($NewWindow, 256)
			Case $WindowRenameButton
				If GUICtrlRead($NewWindow) = "" Then
					GUICtrlSetData($WindowRenameResult, WinGetTitle(GUICtrlRead($OldWindow)))
				Else
					$current = WinGetTitle(GUICtrlRead($OldWindow))
					If WinSetTitle(GUICtrlRead($OldWindow), "", GUICtrlRead($NewWindow)) Then
						GUICtrlSetData($WindowRenameResult, "Đổi tên thành công.")
						$LastOldWindow = $current
						$LastNewWindow = GUICtrlRead($NewWindow)
					Else
						GUICtrlSetData($WindowRenameResult, "Không tìm thấy cửa sổ với tên đã nhập.")
					EndIf
				EndIf
			Case $UndoRenameButton
				If $LastNewWindow = "" And $LastOldWindow = "" Then
					GUICtrlSetData($WindowRenameResult, "Chưa thực hiện đổi tên cửa sổ trước đó.")
				Else
					If WinSetTitle($LastNewWindow, "", $LastOldWindow) Then
						GUICtrlSetData($WindowRenameResult, "Hoàn tác đổi tên thành công.")
						GUICtrlSetData($OldWindow, $LastOldWindow)
						GUICtrlSetData($NewWindow, $LastNewWindow)
						$LastOldWindow = GUICtrlRead($NewWindow)
						$LastNewWindow = GUICtrlRead($OldWindow)
					Else
						GUICtrlSetData($WindowRenameResult, "Không tìm thấy cửa sổ với tên đã nhập.")
					EndIf
				EndIf
			Case $AutoZombieWinHelpButton
				CreateHelpGUI('Yêu cầu cho chế độ đã đăng nhập:' & @CRLF & _
						'* Mở 1 cửa sổ Boom.' & @CRLF & _
						'* Vào phòng chế độ Zombie và chạy auto.' & @CRLF & _
						'* Nếu chạy ở vai trò chủ phòng, hãy nhập đúng mật khẩu phòng như đã nhập trong giao diện chọn auto ' & _
						'để các nhân vật khách có thể tham gia vào phòng.' & @CRLF & _
						"" & @CRLF & _
						'* Lưu ý rằng chế độ này không thể làm tăng tỉ lệ thắng mà chỉ có thể dùng để làm tăng điểm guild. ' & _
						'Khuyến cáo bỏ trang bị thú ra khỏi tất cả các nhân vật tham gia auto để ván chơi kết thúc nhanh hơn.' & @CRLF & @CRLF & _
						'Dùng phím Esc hoặc nút đóng để trở về giao diện chọn auto.')
			Case $AutoZombieWinSaveButton
				Do
					$savedata = MsgBox(3 + 32 + 512, "Lưu thông tin đăng nhập?", _
							"Bạn có muốn mã hoá mật khẩu khi lưu thông tin đăng nhập không?", 0, $MainGUI)
					If $savedata = 2 Then ExitLoop
					FileSetAttrib("AutoBoom-TDStoneheart-AutoZombieWin.txt", "-H")
					$AutoZombieWinSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoZombieWin.txt", 2 + 256)
					If FileWriteLine($AutoZombieWinSavedLogin, "AutoBoom-TDStoneheart-AutoZombieWin / Login Data") = 0 Then
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
						ExitLoop
					EndIf
					FileWriteLine($AutoZombieWinSavedLogin, "")
					FileWriteLine($AutoZombieWinSavedLogin, GUICtrlRead($ServerHN5))
					FileWriteLine($AutoZombieWinSavedLogin, "")
					For $i = 1 To 3
						FileWriteLine($AutoZombieWinSavedLogin, GUICtrlRead($player[$i][$AutoZombieWinMulti]))
						FileWriteLine($AutoZombieWinSavedLogin, $savedata = 6 ? _
								StringEncrypt(True, GUICtrlRead($password[$i][$AutoZombieWinMulti])) : _
								GUICtrlRead($password[$i][$AutoZombieWinMulti]))
					Next
					FileWriteLine($AutoZombieWinSavedLogin, "")
					FileWriteLine($AutoZombieWinSavedLogin, GUICtrlRead($HostModeCheck))
					If FileFlush($AutoZombieWinSavedLogin) Then
						FileClose($AutoZombieWinSavedLogin)
						FileSetAttrib("AutoBoom-TDStoneheart-AutoZombieWin.txt", "+H")
						MsgBox(64, "Đã lưu tệp", "Lưu thông tin đăng nhập thành công.", 0, $MainGUI)
					Else
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
					EndIf
				Until 1
			Case $AutoZombieWinButton
				Do
					If GUICtrlRead($InsideRoomLoggedIn5) = 1 Then
						If Not WinExists("[CLASS:Crazy Arcade]") Then
							MsgBox(16, "Chưa đăng nhập", "Chưa tạo cửa sổ Boom.", 0, $MainGUI)
							ExitLoop
						ElseIf Not (WinGetTitle("[CLASS:Crazy Arcade]") == "b1") Then
							MsgBox(48, "Cần đổi tên cửa sổ", "Auto sẽ đổi tên cửa sổ Boom để tương tác trên cửa sổ đó.")
							If Not WinSetTitle("[CLASS:Crazy Arcade]", "", "b1") Then
								MsgBox(16, "Không thể đổi tên cửa sổ", "Vui lòng đổi tên cửa sổ thủ công.")
								ExitLoop
							EndIf
						EndIf
					ElseIf GUICtrlRead($player[1][$AutoZombieWinMulti]) = "" Or _
							GUICtrlRead($password[1][$AutoZombieWinMulti]) = "" Then
						MsgBox(16, "Thiếu thông tin đăng nhập", 'Đánh dấu "Đã đăng nhập" hoặc nhập thông tin đăng nhập.', 0, $MainGUI)
						ExitLoop
					EndIf
					If (GUICtrlRead($HostModeCheck) = 4) And (String(GUICtrlRead($player[3][$AutoZombieWinMulti])) = "") Then
						If MsgBox(32 + 4, "Chưa có thông tin chủ phòng", _
								"Bạn có chắc chắn muốn tiếp tục mà không có tên nhân vật của chủ phòng không?" & @CRLF & _
								"Nếu có, auto sẽ không thể đăng nhập lại vào phòng của chủ phòng đã định.") = 7 Then ExitLoop
					EndIf
					If String(GUICtrlRead($password[3][$AutoZombieWinMulti])) = "" Then
						If MsgBox(32 + 4, "Chưa nhập mật khẩu phòng", _
								"Bạn có chắc chắn muốn tiếp tục mà không có mật khẩu phòng không?") = 7 Then ExitLoop
					EndIf
					$windows = 1
					For $i = 1 To 3
						$pl[$i] = GUICtrlRead($player[$i][$AutoZombieWinMulti])
						$pass[$i] = GUICtrlRead($password[$i][$AutoZombieWinMulti])
					Next
					$svrHN = GUICtrlRead($ServerHN5)
					$login = GUICtrlRead($InsideRoomLoggedIn5)
					$HostMode = GUICtrlRead($HostModeCheck)
					$ChannelName = GUICtrlRead($ChannelSelect5)
					AssignChannel($ChannelName)
					WinFade($MainGUI, "", 225, 0, -25)
					GUIDelete($MainGUI)
					$ActiveTab = $AutoZombieWinMulti
					Return PrepareForAuto()
				Until 1
			Case $HostModeCheck
				GUICtrlSetState($player[3][$AutoZombieWinMulti], (GUICtrlRead($HostModeCheck) = 1) ? 128 : 64)
			Case $ServerHN4
				GUICtrlSetData($ChannelSelect4_1, LadderChannels(GUICtrlRead($ServerHN4)), "TD-02")
				GUICtrlSetData($ChannelSelect4_2, LadderChannels(GUICtrlRead($ServerHN4)), "TD-04")
			Case $AutoLadderHelpButton
				CreateHelpGUI('Yêu cầu cho chế độ đã đăng nhập:' & @CRLF & _
						'* Mở 2 hoặc 3 cửa sổ Boom.' & @CRLF & _
						'* "b1" đăng nhập chính, "b2" (và "b3" nếu có) đăng nhập phụ.' & @CRLF & _
						'* Số nhân vật đăng nhập trên mọi cửa sổ phải bằng nhau.' & @CRLF & _
						'* Đưa tất cả các cửa sổ ở phòng chờ kênh đầu tiên (trong 2 kênh đã chọn) và chạy auto.' & @CRLF & _
						"" & @CRLF & _
						'Yêu cầu chung:' & @CRLF & _
						'* Khuyến cáo bỏ trang bị nhãn ra khỏi mọi nhân vật tham gia auto để auto nhận diện màu nhãn khớp nhau tốt hơn.' & @CRLF & _
						"" & @CRLF & _
						'Dùng phím Esc hoặc nút đóng để trở về giao diện chọn auto.')
			Case $AutoLadderSaveButton
				Do
					$savedata = MsgBox(3 + 32 + 512, "Lưu thông tin đăng nhập?", _
							"Bạn có muốn mã hoá mật khẩu khi lưu thông tin đăng nhập không?", 0, $MainGUI)
					If $savedata = 2 Then ExitLoop
					FileSetAttrib("AutoBoom-TDStoneheart-AutoLadder.txt", "-H")
					$AutoLadderSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoLadder.txt", 2 + 256)
					If FileWriteLine($AutoLadderSavedLogin, "AutoBoom-TDStoneheart-AutoLadder / Login Data") = 0 Then
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
						ExitLoop
					EndIf
					FileWriteLine($AutoLadderSavedLogin, "")
					FileWriteLine($AutoLadderSavedLogin, GUICtrlRead($ServerHN4))
					For $i = 1 To 3
						FileWriteLine($AutoLadderSavedLogin, "")
						FileWriteLine($AutoLadderSavedLogin, GUICtrlRead($player[2 * $i - 1][$AutoLadder]))
						FileWriteLine($AutoLadderSavedLogin, $savedata = 6 ? StringEncrypt(True, GUICtrlRead($password[2 * $i - 1][$AutoLadder])) : _
								GUICtrlRead($password[2 * $i - 1][$AutoLadder]))
						FileWriteLine($AutoLadderSavedLogin, GUICtrlRead($player[2 * $i][$AutoLadder]))
						FileWriteLine($AutoLadderSavedLogin, $savedata = 6 ? StringEncrypt(True, GUICtrlRead($password[2 * $i][$AutoLadder])) : _
								GUICtrlRead($password[2 * $i][$AutoLadder]))
					Next
					FileWriteLine($AutoLadderSavedLogin, "")
					FileWriteLine($AutoWinSavedLogin, GUICtrlRead($InModeSelect))
					If FileFlush($AutoLadderSavedLogin) Then
						FileClose($AutoLadderSavedLogin)
						FileSetAttrib("AutoBoom-TDStoneheart-AutoLadder.txt", "+H")
						MsgBox(64, "Đã lưu tệp", "Lưu thông tin đăng nhập thành công.", 0, $MainGUI)
					Else
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
					EndIf
				Until 1
			Case $AutoLadderButton
				If GUICtrlRead($InsideRoomLoggedIn3) = 4 Then
					$matched = False
					For $i = 1 To 3 Step 2
						If GUICtrlRead($player[$i][$AutoLadder]) = "" Or GUICtrlRead($password[$i][$AutoLadder]) = "" Then
							$matched = True
							ExitLoop
						EndIf
					Next
					If Not $matched Then
						For $i = 2 To 2 Step 2
							If BitXOR(Not BitXOR(GUICtrlRead($player[$i][$AutoLadder]) = "", _
									GUICtrlRead($password[$i][$AutoLadder]) = ""), _
									Not BitXOR(GUICtrlRead($player[$i + 2][$AutoLadder]) = "", _
									GUICtrlRead($password[$i + 2][$AutoLadder]) = "")) Then
								$matched = True
								ExitLoop
							EndIf
						Next
					EndIf
					If $matched Then
						$windows = 0
						MsgBox(16, "Thiếu thông tin đăng nhập", 'Đánh dấu "Đã đăng nhập" hoặc nhập thông tin đăng nhập.', 0, $MainGUI)
					ElseIf GUICtrlRead($player[5][$AutoLadder]) <> "" And GUICtrlRead($password[5][$AutoLadder]) And _
							Not BitXOR(Not BitXOR(GUICtrlRead($player[4][$AutoLadder]) = "", _
							GUICtrlRead($password[4][$AutoLadder]) = ""), _
							Not BitXOR(GUICtrlRead($player[6][$AutoLadder]) = "", _
							GUICtrlRead($password[6][$AutoLadder]) = "")) Then
						$windows = 3
					Else
						$windows = 2
					EndIf
				ElseIf Not (WinExists("b1") And WinExists("b2")) Then
					$windows = 0
					MsgBox(16, "Chưa đăng nhập", "Chưa tạo đủ các cửa sổ Boom.", 0, $MainGUI)
				ElseIf WinExists("b3") Then
					$windows = 3
				Else
					$windows = 2
				EndIf
				If $windows <> 0 Then
					If (GUICtrlRead($ChannelSelect4_1) = GUICtrlRead($ChannelSelect4_2)) And ($windows <> 3) Then
						$windows = 0
						MsgBox(16, "Lỗi trong thông tin đăng nhập", 'Không thể lựa chọn 2 kênh giống nhau.', 0, $MainGUI)
					Else
						For $i = 7 To 8
							$pl[$i] = ""
							$pass[$i] = ""
						Next
						For $i = 1 To 6
							$pl[$i] = GUICtrlRead($player[$i][$AutoLadder])
							$pass[$i] = GUICtrlRead($password[$i][$AutoLadder])
						Next
						$svrHN = GUICtrlRead($ServerHN4)
						$login = GUICtrlRead($InsideRoomLoggedIn3)
						$ChannelName = GUICtrlRead($ChannelSelect4_1)
						$ChannelName2 = GUICtrlRead($ChannelSelect4_2)
						AssignChannel($ChannelName)
						WinFade($MainGUI, "", 225, 0, -25)
						GUIDelete($MainGUI)
						$ActiveTab = $AutoLadder
						Return PrepareForAuto()
					EndIf
				EndIf
			Case $AutoEXPSaveButton
				Do
					$savedata = MsgBox(3 + 32 + 512, "Lưu thông tin đăng nhập?", _
							"Bạn có muốn mã hoá mật khẩu khi lưu thông tin đăng nhập không?", 0, $MainGUI)
					If $savedata = 2 Then ExitLoop
					FileSetAttrib("AutoBoom-TDStoneheart-AutoEXP.txt", "-H")
					$AutoEXPSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoEXP.txt", 2 + 256)
					If FileWriteLine($AutoEXPSavedLogin, "AutoBoom-TDStoneheart-AutoEXP / Login Data") = 0 Then
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
						ExitLoop
					EndIf
					FileWriteLine($AutoEXPSavedLogin, "")
					FileWriteLine($AutoEXPSavedLogin, GUICtrlRead($ServerHN3))
					For $i = 1 To 4
						FileWriteLine($AutoEXPSavedLogin, "")
						FileWriteLine($AutoEXPSavedLogin, GUICtrlRead($player[2 * $i - 1][$AutoEXP]))
						FileWriteLine($AutoEXPSavedLogin, $savedata = 6 ? StringEncrypt(True, GUICtrlRead($password[2 * $i - 1][$AutoEXP])) : _
								GUICtrlRead($password[2 * $i - 1][$AutoEXP]))
						FileWriteLine($AutoEXPSavedLogin, GUICtrlRead($player[2 * $i][$AutoEXP]))
						FileWriteLine($AutoEXPSavedLogin, $savedata = 6 ? StringEncrypt(True, GUICtrlRead($password[2 * $i][$AutoEXP])) : _
								GUICtrlRead($password[2 * $i][$AutoEXP]))
					Next
					FileWriteLine($AutoEXPSavedLogin, "")
					FileWriteLine($AutoEXPSavedLogin, ExpModeFromGUI())
					If FileFlush($AutoEXPSavedLogin) Then
						FileClose($AutoEXPSavedLogin)
						FileSetAttrib("AutoBoom-TDStoneheart-AutoEXP.txt", "+H")
						MsgBox(64, "Đã lưu tệp", "Lưu thông tin đăng nhập thành công.", 0, $MainGUI)
					Else
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
					EndIf
				Until 1
			Case $AutoEXPInstructionsButton
				CreateHelpGUI('Yêu cầu chung cho chế độ đã đăng nhập:' & @CRLF & _
						'* Mở tối thiểu 2 và tối đa 4 cửa sổ Boom. Càng ít cửa sổ, điểm kinh nghiệm nhận được càng ít.' & @CRLF & _
						'* Đổi tên các cửa sổ thành "b1", "b2", "b3", "b4". Tên cửa sổ không chứa dấu ngoặc kép. ' & _
						'Có thể dùng module đổi tên cửa sổ ở bảng chọn "Khác" để thực hiện đổi tên.' & @CRLF & _
						'* Đăng nhập các cửa sổ với số nhân vật tuỳ ý, riêng "b1" & "b2" bắt buộc đăng nhập 2P.' & @CRLF & _
						"* Đưa tất cả các cửa sổ vào chung một phòng với các điều kiện tuỳ từng chế độ. Bản đồ sẽ được chỉnh tự động." & @CRLF & _
						'' & @CRLF & _
						'Chế độ 0: Nhà máy 01' & @CRLF & _
						'* Nhân vật điều khiển phím mũi tên ở "b1" làm chính (1P nếu đăng nhập 1P, 2P nếu đăng nhập 2P), ' & _
						'mọi nhân vật còn lại làm phụ.' & @CRLF & _
						'* Các nhân vật của "b1" và 1P của "b2" có đội màu 3 (cam). Các nhân vật còn lại màu khác tuỳ ý.' & @CRLF & _
						'* Riêng "b2" không bật sẵn sàng và không để tự động sẵn sàng khi chạy auto.' & @CRLF & _
						'* Khuyến cáo bỏ trang bị thú ra khỏi tất cả các nhân vật tham gia auto.' & @CRLF & _
						'' & @CRLF & _
						'Chế độ 1: Zombie (1)' & @CRLF & _
						'* "b1" làm chính, mọi nhân vật còn lại làm phụ.' & @CRLF & _
						'' & @CRLF & _
						'Chế độ 2: Zombie (2)' & @CRLF & _
						'* Có thể chỉ đăng nhập 1 cửa sổ.' & @CRLF & _
						'* Tất cả cùng thắng và điểm kinh nghiệm không biết trước.' & @CRLF & _
						'* Có thể kiếm vàng cho một trong các nhân vật tham gia auto bằng chế độ này.' & @CRLF & _
						'* Không phân chia nhân vật chính/phụ rõ ràng.' & @CRLF & _
						'' & @CRLF & _
						'Chế độ 3: Zombie (3)' & @CRLF & _
						'* Đăng nhập các nhân vật theo thứ tự ưu tiên giảm dần.' & @CRLF & _
						'* Nhân vật điều khiển phím mũi tên ở "b1" làm chính.' & @CRLF & _
						'* Có thể kiếm vàng cho một trong các nhân vật tham gia auto bằng chế độ này.' & @CRLF & _
						'' & @CRLF & _
						'Yêu cầu chung cho các chế độ zombie:' & @CRLF & _
						'* Để tất cả bật sẵn sàng và tự động sẵn sàng rồi chạy auto.' & @CRLF & _
						'* Trang bị thú cưng (nếu có) để nhận thêm điểm kinh nghiệm.' & @CRLF & _
						'' & @CRLF & _
						'Dùng phím Esc hoặc nút đóng để trở về giao diện chọn auto.')
			Case $AutoEXPButton
				If GUICtrlRead($InsideRoomLoggedIn2) = 4 Then
					If GUICtrlRead($player[1][$AutoEXP]) = "" Or GUICtrlRead($password[1][$AutoEXP]) = "" Or _
							GUICtrlRead($player[2][$AutoEXP]) = "" Or GUICtrlRead($password[2][$AutoEXP]) = "" Then
						$windows = 0
						MsgBox(16, "Thiếu thông tin đăng nhập", 'Đánh dấu "Đã đăng nhập" hoặc nhập thông tin đăng nhập.', 0, $MainGUI)
					ElseIf GUICtrlRead($player[7][$AutoEXP]) <> "" And GUICtrlRead($password[7][$AutoEXP]) <> "" Then
						$windows = 4
					ElseIf GUICtrlRead($player[5][$AutoEXP]) <> "" And GUICtrlRead($password[5][$AutoEXP]) <> "" Then
						$windows = 3
					ElseIf GUICtrlRead($player[3][$AutoEXP]) <> "" And GUICtrlRead($password[3][$AutoEXP]) <> "" Then
						If GUICtrlRead($player[4][$AutoEXP]) <> "" And GUICtrlRead($password[4][$AutoEXP]) <> "" Then
							$windows = 2
						Else
							$windows = 0
							MsgBox(16, "Thiếu thông tin đăng nhập", 'Đánh dấu "Đã đăng nhập" hoặc nhập thông tin đăng nhập.', 0, $MainGUI)
						EndIf
					ElseIf ExpModeFromGUI() = 2 Then
						$windows = 1
					Else
						$windows = 0
						MsgBox(16, "Thiếu thông tin đăng nhập", 'Đánh dấu "Đã đăng nhập" hoặc nhập thông tin đăng nhập.', 0, $MainGUI)
					EndIf
				ElseIf (ExpModeFromGUI() <> 2 And Not (WinExists("b1") And WinExists("b2"))) Or _
						(ExpModeFromGUI() = 2 And Not (WinExists("b1"))) Then
					$windows = 0
					MsgBox(16, "Chưa đăng nhập", "Chưa tạo đủ các cửa sổ Boom.", 0, $MainGUI)
				Else
					$windows = 1
					For $c = 2 To 4
						If WinExists("b" & $c) Then
							$windows = $c
						Else
							ExitLoop
						EndIf
					Next
				EndIf
				If $windows <> 0 Then
					For $i = 1 To 8
						$pl[$i] = GUICtrlRead($player[$i][$AutoEXP])
						$pass[$i] = GUICtrlRead($password[$i][$AutoEXP])
					Next
					$svrHN = GUICtrlRead($ServerHN3)
					$login = GUICtrlRead($InsideRoomLoggedIn2)
					$expmode = ExpModeFromGUI()
					$ChannelName = GUICtrlRead($ChannelSelect3)
					AssignChannel($ChannelName)
					WinFade($MainGUI, "", 225, 0, -25)
					GUIDelete($MainGUI)
					$ActiveTab = $AutoEXP
					Return PrepareForAuto()
				EndIf
			Case $ZombieMode[0], $ZombieMode[1], $ZombieMode[2], $ZombieMode[3], $WhoModeSelect
				GroupRename($GUIMsg = $WhoModeSelect ? $AutoWho : $AutoEXP)
			Case $AutoWinSaveButton
				Do
					$savedata = MsgBox(3 + 32 + 512, "Lưu thông tin đăng nhập?", _
							"Bạn có muốn mã hoá mật khẩu khi lưu thông tin đăng nhập không?", 0, $MainGUI)
					If $savedata = 2 Then ExitLoop
					FileSetAttrib("AutoBoom-TDStoneheart-AutoWin.txt", "-H")
					$AutoWinSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoWin.txt", 2 + 256)
					If FileWriteLine($AutoWinSavedLogin, "AutoBoom-TDStoneheart-AutoWin / Login Data") = 0 Then
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
						ExitLoop
					EndIf
					FileWriteLine($AutoWinSavedLogin, "")
					FileWriteLine($AutoWinSavedLogin, GUICtrlRead($ServerHN))
					For $i = 1 To 4
						FileWriteLine($AutoWinSavedLogin, "")
						FileWriteLine($AutoWinSavedLogin, GUICtrlRead($player[2 * $i - 1][$AutoWho]))
						FileWriteLine($AutoWinSavedLogin, $savedata = 6 ? StringEncrypt(True, GUICtrlRead($password[2 * $i - 1][$AutoWho])) : _
								GUICtrlRead($password[2 * $i - 1][$AutoWho]))
						FileWriteLine($AutoWinSavedLogin, GUICtrlRead($player[2 * $i][$AutoWho]))
						FileWriteLine($AutoWinSavedLogin, $savedata = 6 ? StringEncrypt(True, GUICtrlRead($password[2 * $i][$AutoWho])) : _
								GUICtrlRead($password[2 * $i][$AutoWho]))
					Next
					FileWriteLine($AutoWinSavedLogin, "")
					FileWriteLine($AutoWinSavedLogin, WhoModeFromGUI())
					FileWriteLine($AutoWinSavedLogin, GUICtrlRead($InModeSelect))
					If FileFlush($AutoWinSavedLogin) Then
						FileClose($AutoWinSavedLogin)
						FileSetAttrib("AutoBoom-TDStoneheart-AutoWin.txt", "+H")
						MsgBox(64, "Đã lưu tệp", "Lưu thông tin đăng nhập thành công." & _
								@CRLF & "Ý tưởng lưu thông tin đăng nhập bởi Hùng Idol.", 0, $MainGUI)
					Else
						MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.", 0, $MainGUI)
					EndIf
				Until 1
			Case $AutoWinInstructionsButton
				CreateHelpGUI("Yêu cầu đối với chế độ đã đăng nhập:" & @CRLF & _
						'* Mở tối thiểu 2 và tối đa 4 cửa sổ Boom.' & @CRLF & _
						'* Đổi tên các cửa sổ thành "b1", "b2", "b3", "b4". Tên cửa sổ không chứa dấu ngoặc kép. ' & _
						'Có thể dùng module đổi tên cửa sổ ở bảng chọn "Khác" để thực hiện đổi tên.' & @CRLF & _
						'* Đăng nhập các nhân vật chính ở cửa sổ "b2", "b3", "b4", phụ ở cửa sổ "b1". ' & _
						'Có thể đăng nhập với số nhân vật tuỳ ý.' & @CRLF & _
						'* Cài đặt câu lệnh ALT+1 của các cửa sổ chính là "/who [tên nhân vật phụ ở "b1"]" (không có dấu ngoặc kép) ' & _
						'nếu không sử dụng chế độ Zombie.' & @CRLF & _
						"* Đưa tất cả các cửa sổ vào chung một phòng với các điều kiện sau:" & @CRLF & _
						" - Khuyến nghị chọn chế độ đội tự do." & @CRLF & _
						' - Cửa sổ phụ ("b1") làm chủ phòng.' & @CRLF & _
						" - Các nhân vật của các cửa sổ chính cùng màu/đội với nhau." & @CRLF & _
						"* Tiến hành chạy auto." & @CRLF & _
						"* Mẹo: Có thể tạo các cửa sổ theo yêu cầu rồi đưa tất cả các cửa sổ ở ngoài phòng chờ cùng một kênh và " & _
						"thực hiện auto ở chế độ chưa đăng nhập. Auto sẽ tự tạo phòng và thực hiện auto như bình thường. " & _
						"(Chế độ tự sẵn sàng cũng sẽ được đặt tự động, nhưng chú ý câu lệnh ALT+1 và " & _
						"thông tin đăng nhập trên giao diện trước khi chạy auto!)" & @CRLF & @CRLF & _
						"* Ở chế độ sự kiện, cửa sổ phụ sẽ ở lại trận đấu khoảng 20 giây rồi mới thoát ra " & _
						"để thực hiện yêu cầu thắng của một số nhiệm vụ / sự kiện nhất định." & @CRLF & _
						'* Khi có sự kiện "Hộp kho báu may mắn", tất cả các cửa sổ sẽ đợi để mở hộp kho báu. ' & _
						'(Ý tưởng của Trung Hải Phòng)' & @CRLF & _
						'* Chế độ Zombie chậm hơn nhưng sử dụng ít hơn 1 cửa sổ (có thể chỉ đăng nhập 1 cửa sổ) ' & _
						'và không có nhân vật nào làm phụ. Tất cả các nhân vật tham gia auto cùng thắng. ' & _
						'Lưu ý rằng chế độ này không thể làm tăng tỉ lệ thắng mà chỉ có thể dùng để làm tăng điểm guild. ' & _
						'Khuyến cáo bỏ trang bị thú ra khỏi tất cả các nhân vật tham gia auto để ván chơi kết thúc nhanh hơn.' & @CRLF & @CRLF & _
						'Dùng phím Esc hoặc nút đóng để trở về giao diện chọn auto.')
			Case $AutoWinButton
				$whomode = WhoModeFromGUI()
				If GUICtrlRead($InsideRoomLoggedIn) = 4 Then
					If GUICtrlRead($player[1][$AutoWho]) = "" Or GUICtrlRead($password[1][$AutoWho]) = "" Then
						$windows = 0
						MsgBox(16, "Thiếu thông tin đăng nhập", 'Đánh dấu "Đã đăng nhập" hoặc nhập thông tin đăng nhập.', 0, $MainGUI)
					ElseIf GUICtrlRead($player[7][$AutoWho]) <> "" And GUICtrlRead($password[7][$AutoWho]) <> "" Then
						$windows = 4
					ElseIf GUICtrlRead($player[5][$AutoWho]) <> "" And GUICtrlRead($password[5][$AutoWho]) <> "" Then
						$windows = 3
					ElseIf GUICtrlRead($player[3][$AutoWho]) <> "" And GUICtrlRead($password[3][$AutoWho]) <> "" Then
						$windows = 2
					ElseIf $whomode <> 2 Or _
						($whomode = 2 And (GUICtrlRead($player[2][$AutoWho]) = "" Or GUICtrlRead($password[2][$AutoWho]) = "")) Then
						$windows = 0
						MsgBox(16, "Thiếu thông tin đăng nhập", 'Đánh dấu "Đã đăng nhập" hoặc nhập thông tin đăng nhập.', 0, $MainGUI)
					Else
						$windows = 1
					EndIf
				ElseIf ($whomode <> 2 And Not (WinExists("b1") And WinExists("b2"))) Or _
						($whomode = 2 And Not (WinExists("b1"))) Then
					$windows = 0
					MsgBox(16, "Chưa đăng nhập", "Chưa tạo đủ các cửa sổ Boom.", 0, $MainGUI)
				Else
					$windows = 1
					For $c = 2 To 4
						If WinExists("b" & $c) Then
							$windows = $c
						Else
							ExitLoop
						EndIf
					Next
				EndIf
				If $windows <> 0 Then
					For $i = 1 To 8
						$pl[$i] = GUICtrlRead($player[$i][$AutoWho])
						$pass[$i] = GUICtrlRead($password[$i][$AutoWho])
					Next
					$InviteMode = GUICtrlRead($InModeSelect)
					$svrHN = GUICtrlRead($ServerHN)
					$login = GUICtrlRead($InsideRoomLoggedIn)
					$ChannelName = GUICtrlRead($ChannelSelect)
					AssignChannel($ChannelName)
					WinFade($MainGUI, "", 225, 0, -25)
					GUIDelete($MainGUI)
					$ActiveTab = $AutoWho
					Return PrepareForAuto()
				EndIf
			Case $AutoNeedleButton
				$ChannelName = GUICtrlRead($ChannelSelect2)
				AssignChannel($ChannelName)
				$ActiveTab = $AutoNeedle
				If Not Number(GUICtrlRead($LoginInput)) Then
					$AutoNeedleSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoNeedle.txt", 256)
					If $AutoNeedleSavedLogin = -1 Then
						MsgBox(48, "Không thể chuyển nhập thông tin", "Mở tệp thông tin đã lưu thất bại.", 0, $MainGUI)
					Else
						$svrHN = FileReadLine($AutoNeedleSavedLogin, 3)
						$LevelSpinMode = FileReadLine($AutoNeedleSavedLogin)
						If $svrHN <> 1 And $svrHN <> 4 Then $svrHN = GUICtrlRead($ServerHN2)
						WinFade($MainGUI, "", 225, 0, -25)
						GUIDelete($MainGUI)
						FileReadLine($AutoNeedleSavedLogin)
						$pl[1] = FileReadLine($AutoNeedleSavedLogin)
						If $pl[1] = "" Or @error = -1 Then
							$windows = 0
						Else
							$c = 1
							While 1
								$temppassword = FileReadLine($AutoNeedleSavedLogin)
								$pass[2 * $c - 1] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
								$pl[2 * $c] = FileReadLine($AutoNeedleSavedLogin)
								$temppassword = FileReadLine($AutoNeedleSavedLogin)
								$pass[2 * $c] = (StringLen($temppassword) <= 8) ? $temppassword : StringEncrypt(False, $temppassword)
								FileReadLine($AutoNeedleSavedLogin)
								$pl[2 * $c + 1] = FileReadLine($AutoNeedleSavedLogin)
								If @error = -1 Then
									$windows = $c
									ExitLoop
								Else
									$c += 1
								EndIf
							WEnd
						EndIf
						FileClose($AutoNeedleSavedLogin)
						$AutoNeedleImported = GUICreate($autoname, 320, $GUIHeight)
						GUIFont()
						GUICtrlCreateLabel("Chuyển nhập thành công thông tin của " & StringFormat("%02i", $windows) & " lần đăng nhập.", 16, 12, 220, 32)
						$AutoNeedleProceedButton = GUICtrlCreateButton("OK", 240, 12, 64, 32, $BS_DEFPUSHBUTTON)
						$ImportedList = GUICtrlCreateEdit("", 16, 50, 288, $GUIHeight - 60, 0x00200804)
						GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
						GUICtrlSetData($ImportedList, "Server: " & ($svrHN = 1 ? "HN" : "HCM") & @CRLF & @CRLF, 1)
						For $c = 1 To $windows
							GUICtrlSetData($ImportedList, StringFormat("%02i", $c) & @CRLF, 1)
							GUICtrlSetData($ImportedList, $pl[2 * $c - 1], 1)
							For $i = 1 To (15 - StringLen($pl[2 * $c - 1]))
								GUICtrlSetData($ImportedList, Chr(160), 1)
							Next
							GUICtrlSetData($ImportedList, $pl[2 * $c] & @CRLF, 1)
							For $i = 1 To StringLen($pass[2 * $c - 1])
								GUICtrlSetData($ImportedList, Chr(149), 1)
							Next
							For $i = 1 To (15 - StringLen($pass[2 * $c - 1]))
								GUICtrlSetData($ImportedList, Chr(160), 1)
							Next
							For $i = 1 To StringLen($pass[2 * $c]) * Bit($pl[2 * $c] <> "")
								GUICtrlSetData($ImportedList, Chr(149), 1)
							Next
							GUICtrlSetData($ImportedList, @CRLF & @CRLF, 1)
						Next
						WinSetTrans($AutoNeedleImported, "", 0)
						GUISetState(@SW_SHOW, $AutoNeedleImported)
						WinFade($AutoNeedleImported, "", 0, 225, 25)
						While 1
							Switch GUIGetMsg()
								Case $AutoNeedleProceedButton, $GUI_EVENT_CLOSE
									WinFade($AutoNeedleImported, "", 225, 0, -25)
									GUIDelete($AutoNeedleImported)
									ExitLoop
							EndSwitch
						WEnd
					EndIf
				Else
					$svrHN = GUICtrlRead($ServerHN2)
					$windows = GUICtrlRead($LoginInput)
					$LevelSpinMode = GUICtrlRead($LevelSpinCheck)
					WinFade($MainGUI, "", 225, 0, -25)
					GUIDelete($MainGUI)
					For $c = 1 To $windows
						$NeedleLogin = GUICreate(StringFormat("%02i", $c) & "/" & StringFormat("%02i", $windows), 320, 120, -1, -1)
						WinSetTrans($NeedleLogin, "", 225)
						GUIFont()
						$player1 = GUICtrlCreateInput("", 88, 31, 96, 23)
						GUICtrlSetLimit(-1, 12)
						GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
						$password1 = GUICtrlCreateInput("", 88, 58, 96, 23, $ES_PASSWORD)
						GUICtrlSetLimit(-1, 8)
						GUICtrlSetFont(-1, 9, 0, 0, "Courier New")
						$player2 = GUICtrlCreateInput("", 188, 31, 96, 23)
						GUICtrlSetLimit(-1, 12)
						GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
						$password2 = GUICtrlCreateInput("", 188, 58, 96, 23, $ES_PASSWORD)
						GUICtrlSetLimit(-1, 8)
						GUICtrlSetFont(-1, 9, 0, 0, "Courier New")
						GUICtrlCreateLabel("1P", 88, 12, 96, 17, $SS_CENTER)
						GUICtrlCreateLabel("2P", 188, 12, 96, 17, $SS_CENTER)
						GUICtrlCreateLabel("Nhân vật", 32, 31, 50, 17)
						GUICtrlCreateLabel("Mật khẩu", 32, 58, 50, 17)
						$NeedleLoginButton = GUICtrlCreateButton("OK", 110, 90, 100, 25, $BS_DEFPUSHBUTTON)
						WinSetTrans($NeedleLogin, "", 0)
						GUISetState(@SW_SHOW, $NeedleLogin)
						WinFade($NeedleLogin, "", 0, 225, 25)
						While 1
							Switch GUIGetMsg()
								Case $GUI_EVENT_CLOSE
									WinFade($NeedleLogin, "", 225, 0, -25)
									GUIDelete($NeedleLogin)
									Select
										Case $c > 1
											If MsgBox(4 + 32, "Chạy auto?", "Bạn có muốn chạy auto với thông tin đăng nhập vừa nhập không?" & _
													@CRLF & "Nếu không, bạn sẽ trở về giao diện chọn auto.") = 6 Then
												$windows = $c - 1
												ExitLoop 2
											Else
												ContinueCase
											EndIf
										Case Else
											Return AutoMainGUI()
									EndSelect
								Case $NeedleLoginButton
									If GUICtrlRead($player1) = "" Or GUICtrlRead($password1) = "" _
											Or BitXOR(GUICtrlRead($player2) = "", GUICtrlRead($password2) = "") Then
										MsgBox(16, "Thiếu thông tin đăng nhập", "Nhập thông tin đăng nhập của ít nhất một nhân vật." & @CRLF & _
												"Đóng cửa sổ đăng nhập để thực hiện auto ngay hoặc trở về giao diện chọn auto.", 0, $NeedleLogin)
									Else
										$pl[2 * $c - 1] = GUICtrlRead($player1)
										$pass[2 * $c - 1] = GUICtrlRead($password1)
										$pl[2 * $c] = GUICtrlRead($player2)
										$pass[2 * $c] = GUICtrlRead($password2)
										WinFade($NeedleLogin, "", 225, 0, -25)
										GUIDelete($NeedleLogin)
										ExitLoop
									EndIf
							EndSwitch
						WEnd
					Next
					Do
						$savedata = MsgBox(3 + 32 + 512, "Lưu thông tin đăng nhập?", _
								"Bạn có muốn mã hoá mật khẩu khi lưu thông tin đăng nhập không?")
						If $savedata = 2 Then ExitLoop
						FileSetAttrib("AutoBoom-TDStoneheart-AutoNeedle.txt", "-H")
						$AutoNeedleSavedLogin = FileOpen("AutoBoom-TDStoneheart-AutoNeedle.txt", 2 + 256)
						If FileWriteLine($AutoNeedleSavedLogin, "AutoBoom-TDStoneheart-AutoNeedle / Login Data") = 0 Then
							MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.")
							ExitLoop
						EndIf
						FileWriteLine($AutoNeedleSavedLogin, "")
						FileWriteLine($AutoNeedleSavedLogin, $svrHN)
						FileWriteLine($AutoNeedleSavedLogin, $LevelSpinMode)
						For $c = 1 To $windows
							FileWriteLine($AutoNeedleSavedLogin, "")
							FileWriteLine($AutoNeedleSavedLogin, $pl[2 * $c - 1])
							FileWriteLine($AutoNeedleSavedLogin, $savedata = 6 ? StringEncrypt(True, $pass[2 * $c - 1]) : $pass[2 * $c - 1])
							FileWriteLine($AutoNeedleSavedLogin, $pl[2 * $c])
							FileWriteLine($AutoNeedleSavedLogin, $savedata = 6 ? StringEncrypt(True, $pass[2 * $c]) : $pass[2 * $c])
						Next
						If FileFlush($AutoNeedleSavedLogin) Then
							FileClose($AutoNeedleSavedLogin)
							FileSetAttrib("AutoBoom-TDStoneheart-AutoNeedle.txt", "+H")
							MsgBox(64, "Đã lưu tệp", "Lưu thông tin đăng nhập thành công." & _
									@CRLF & "Ý tưởng lưu thông tin đăng nhập bởi Hùng Idol.")
						Else
							MsgBox(48, "Không thể lưu tệp.", "Lưu thông tin đăng nhập thất bại.")
						EndIf
					Until 1
				EndIf
				$w = 1
				Return PrepareForAuto()
		EndSwitch
	WEnd
EndFunc

Func CommandLine($iFlag)
	If $iFlag Then ;True generates, False validates
		Local $text = Bit($DebugMode) & ' ' & Bit($DebugModeFlag) & ' "' & StringToHex($DefaultRoomName) & '" ' & _
				$autoloops & ' ' & $ActiveTab & ' ' & $svrHN & ' "' & $ChannelName & '" '
		Switch $ActiveTab
			Case $AutoNeedle
				If $w < 1 Then $w = 1
				$text &= $LevelSpinMode & ' ' & $windows & ' ' & $w & ' '
				For $i = 1 To $windows
					$text &= '"' & StringToHex($pl[$i]) & '" "' & StringToHex($pass[$i]) & '" '
				Next
			Case $AutoZombieWinMulti
				$text &= $HostMode & ' '
				For $i = 1 To 3
					$text &= '"' & StringToHex($pl[$i]) & '" "' & StringToHex($pass[$i]) & '" '
				Next
			Case $AutoLadder
				$text &= $ChannelName2 & ' '
				ContinueCase
			Case Else
				For $i = 1 To 8
					$text &= '"' & StringToHex($pl[$i]) & '" "' & StringToHex($pass[$i]) & '" '
				Next
		EndSwitch
		Switch $ActiveTab
			Case $AutoWho
				$text &= $whomode & ' ' & $InviteMode
			Case $AutoEXP
				$text &= $expmode
			Case $AutoLadder
				$text &= $InviteMode
		EndSwitch
		Return $text
	Else
		If Not IsAdmin() Or $CmdLine[0] < 9 Then Return 0
		$DebugMode = Not Not Number($CmdLine[1])
		$DebugModeFlag = Not Not Number($CmdLine[2])
		$DefaultRoomName = HexToString($CmdLine[3]) ? HexToString($CmdLine[3]) : " "
		$autoloops = Number($CmdLine[4])
		Switch $CmdLine[5]
			Case $AutoWho To $AutoZombieWinMulti
				$ActiveTab = Number($CmdLine[5])
			Case Else
				Return 0
		EndSwitch
		$svrHN = (Number($CmdLine[6]) = 1) ? 1 : 4
		$ChannelName = $CmdLine[7]
		AssignChannel($ChannelName)
		Switch $ActiveTab
			Case $AutoNeedle
				$LevelSpinMode = Number($CmdLine[8])
				$windows = Number($CmdLine[9])
				$w = Number($CmdLine[10])
				For $i = 1 To $windows
					$pl[$i] = HexToString($CmdLine[9 + (2 * $i)])
					$pass[$i] = HexToString($CmdLine[10 + (2 * $i)])
				Next
			Case $AutoZombieWinMulti
				$HostMode = $CmdLine[8]
				For $i = 1 To 3
					$pl[$i] = HexToString($CmdLine[7 + (2 * $i)])
					$pass[$i] = HexToString($CmdLine[8 + (2 * $i)])
				Next
				$windows = 1
			Case $AutoLadder
				$ChannelName2 = $CmdLine[8]
				ContinueCase
			Case Else
				For $i = 1 To 8
					$pl[$i] = HexToString($CmdLine[6 + (2 * $i) + Bit($ActiveTab = $AutoLadder)])
					$pass[$i] = HexToString($CmdLine[7 + (2 * $i) + Bit($ActiveTab = $AutoLadder)])
				Next
				$windows = 0
				For $i = 7 To 1 Step -2
					If $pl[$i] <> "" Then
						$windows = ($i + 1) / 2
						ExitLoop
					EndIf
				Next
				If Not $windows Then Return 0
		EndSwitch
		Switch $ActiveTab
			Case $AutoWho
				Switch $CmdLine[24]
					Case 0 To UBound($AutoWhoMode) - 1
						$whomode = Number($CmdLine[24])
					Case Else
						Return 0
					EndSwitch
				ContinueCase
			Case $AutoLadder
				$InviteMode = (Number($CmdLine[25]) = 1) ? 1 : 4
			Case $AutoEXP
				Switch $CmdLine[24]
					Case 0 To 3
						$expmode = Number($CmdLine[24])
					Case Else
						Return 0
				EndSwitch
		EndSwitch
		$login = 4
		If $DebugMode Then _DebugSetup($autoname & " (Debug/Notepad)", True, _
				$DebugModeFlag ? 4 : 5, "AutoBoom-TDStoneheart-Debug.log", True)
		HotKeySet("^{f9}", "Out")
		HotKeySet("^{f12}", "BackToGUI")
		HotKeySet("+{pause}", "DisableInput")
		Return 1
	EndIf
EndFunc

#Region AuxiliaryFunctions
Func InstallFont($sSourceFile, $sFontDescript = "", $sFontsPath = "")
	Local Const $HWND_BROADCAST = 0xFFFF
	Local Const $WM_FONTCHANGE = 0x1D
	If $sFontsPath = "" Then $sFontsPath = @WindowsDir & "\Fonts"
	Local $sFontName = StringRegExpReplace($sSourceFile, "^.*\\", "")
	FileCopy($sSourceFile, $sFontsPath & "\" & $sFontName, 0)
	Local $hSearch = FileFindFirstFile($sSourceFile)
	Local $iFontIsWildcard = StringRegExp($sFontName, "\*|\?")
	If $hSearch = -1 Then Return SetError(2, 0, 0)
	Local $aRet, $hGdi32_DllOpen = DllOpen("gdi32.dll")
	If $hGdi32_DllOpen = -1 Then Return SetError(3, 0, 0)
	While 1
		$sFontName = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If $iFontIsWildcard Then $sFontDescript = StringRegExpReplace($sFontName, "\.[^\.]*$", "")
		$aRet = DllCall($hGdi32_DllOpen, "Int", "AddFontResource", "str", $sFontsPath & "\" & $sFontName)
		If IsArray($aRet) And $aRet[0] > 0 Then _
				RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", _
				$sFontDescript, "REG_SZ", $sFontsPath & "\" & $sFontName)
	WEnd
	DllClose($hGdi32_DllOpen)
	DllCall("user32.dll", "Int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_FONTCHANGE, "int", 0, "int", 0)
	Return 1
EndFunc

Func WinFade($title, $text, $first, $last, $step)
	If $title = $splashwindow And Not $splashwindow Then Return SetError(1, 0, 0)
	For $i = $first To $last Step $step
		If Not WinSetTrans($title, $text, $i) Then ExitLoop
		Sleep(10)
	Next
	Return WinSetTrans($title, $text, $last)
EndFunc

Func DisableInput()
	If BlockInput(1) Then
		_DebugLine("Input blocked. Press Ctrl+Alt+Delete to unblock.")
		GUISwitch($splashwindow)
		Local $lastsplashtext = GUICtrlRead($splashstatic)
		SplashSet("Đã vô hiệu hoá bàn phím && chuột" & @CRLF & "Ctrl+Alt+Delete: Ngừng chặn")
		Sleep(1000)
		Return SplashSet($lastsplashtext)
	EndIf
EndFunc

Func MouseAway()
	AutoItSetOption("MouseCoordMode", 0)
	MouseMove(@DesktopWidth - 1, Round(@DesktopHeight / 2), 0)
	AutoItSetOption("MouseCoordMode", 2)
	Return 1
EndFunc

Func StringEncrypt($fEncrypt, $sData, $sPassword = "AutoBoom-TDStoneheart")
	; If the flag is set to True then encrypt, otherwise decrypt.
	Return $fEncrypt ? Hex(_Crypt_EncryptData($sData, $sPassword, $CALG_AES_128)) : _
			BinaryToString(_Crypt_DecryptData(((StringLeft($sData, 2) == "0x") ? "" : "0x") & $sData, _
			$sPassword, $CALG_AES_128))
EndFunc

Func HexToString($sHex)
	If Not (StringLeft($sHex, 2) == "0x") Then $sHex = "0x" & $sHex
	Return BinaryToString($sHex, 4)
EndFunc

Func StringToHex($sString)
	Return Hex(StringToBinary($sString, 4))
EndFunc

Func Bit($bool)
	Return $bool ? 1 : 0 ; Number(Not Not $bool)
EndFunc

Func XOR($bool1, $bool2)
	Return (Not Not $bool1 <> Not Not $bool2)
EndFunc

Func GUILoginInput($tab)
	Local $base
	Switch $tab
		Case $AutoWho
			$base = 0
		Case $AutoEXP
			$base = 100
		Case $AutoLadder
			$base = 10
		Case $AutoZombieWinMulti
			$base = 20
	EndSwitch
	For $i = 1 To 4
		If ($i = 4) And ($tab = $AutoLadder) Then ContinueLoop
		$groupname[$i][$tab] = GUICtrlCreateGroup("b" & $i, 24, 82 * ($i - 1) + 31, 272, 79)
		$player[2 * $i - 1][$tab] = GUICtrlCreateInput($pl[2 * $i - 1 + $base], 88, 82 * ($i - 1) + 62, 98, 20)
		GUICtrlSetLimit(-1, 12)
		GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
		$password[2 * $i - 1][$tab] = GUICtrlCreateInput($pass[2 * $i - 1 + $base], 88, 82 * ($i - 1) + 85, 98, 20, $ES_PASSWORD)
		GUICtrlSetLimit(-1, 8)
		GUICtrlSetFont(-1, 9, 0, 0, "Courier New")
		$player[2 * $i][$tab] = GUICtrlCreateInput($pl[2 * $i + $base], 190, 82 * ($i - 1) + 62, 98, 20)
		GUICtrlSetLimit(-1, 12)
		GUICtrlSetFont(-1, 9, 0, 0, $MonoFont)
		$password[2 * $i][$tab] = GUICtrlCreateInput($pass[2 * $i + $base], 190, 82 * ($i - 1) + 85, 98, 20, $ES_PASSWORD)
		GUICtrlSetLimit(-1, 8)
		GUICtrlSetFont(-1, 9, 0, 0, "Courier New")
		GUICtrlCreateLabel("1P", 88, 82 * ($i - 1) + 46, 98, 17, $SS_CENTER)
		GUICtrlCreateLabel("2P", 190, 82 * ($i - 1) + 46, 98, 17, $SS_CENTER)
		GUICtrlCreateLabel("Nhân vật", 32, 82 * ($i - 1) + 62, 50, 20)
		GUICtrlCreateLabel("Mật khẩu", 32, 82 * ($i - 1) + 85, 50, 20)
		GUICtrlCreateGroup("", -99, -99, 1, 1)
		If $tab = $AutoZombieWinMulti Then ExitLoop
	Next
EndFunc

Func GroupRename($tab)
	Switch $tab
		Case $AutoWho
			If WhoModeFromGUI() = 2 Then
				For $i = 1 To 4
					GUICtrlSetData($groupname[$i][$tab], "b" & $i)
				Next
			Else
				GUICtrlSetData($groupname[1][$tab], "b1 (Phụ)")
				For $i = 2 To 4
					GUICtrlSetData($groupname[$i][$tab], "b" & $i & " (Chính " & $i - 1 & ")")
				Next
			EndIf
		Case $AutoEXP
			Switch ExpModeFromGUI()
				Case 0
					GUICtrlSetData($groupname[1][$tab], "b1 (Phụ/Chính)")
					For $i = 2 To 4
						GUICtrlSetData($groupname[$i][$tab], "b" & $i & " (Phụ " & $i - 1 & ")")
					Next
				Case 1
					GUICtrlSetData($groupname[1][$tab], "b1 (Chính)")
					For $i = 2 To 4
						GUICtrlSetData($groupname[$i][$tab], "b" & $i & " (Phụ " & $i - 1 & ")")
					Next
				Case 2
					For $i = 1 To 4
						GUICtrlSetData($groupname[$i][$tab], "b" & $i)
					Next
				Case 3
					For $i = 1 To 4
						GUICtrlSetData($groupname[$i][$tab], "b" & $i & " (Ưu tiên " & $i & ")")
					Next
			EndSwitch
		Case $AutoLadder
			GUICtrlSetData($groupname[1][$tab], "b1 (Chính)")
			GUICtrlSetData($groupname[2][$tab], "b2 (Phụ 1)")
			GUICtrlSetData($groupname[3][$tab], "b3 (Phụ 2)")
		Case $AutoZombieWinMulti
			GUICtrlSetData($groupname[1][$tab], "Đăng nhập")
	EndSwitch
EndFunc

Func GUIButtonCreate($tab, $iFlag = False)
	Local $style = ($iFlag ? 1 : -1) ;$BS_DEFPUSHBUTTON = 1
	Switch $tab
		Case $AutoWho
			$AutoWinButton = GUICtrlCreateButton("Chạy auto", 210, 388, 94, 25, $style)
		Case $AutoNeedle
			$AutoNeedleButton = GUICtrlCreateButton("Đăng nhập", 30, 55, 100, 25, $style)
		Case $AutoEXP
			$AutoEXPButton = GUICtrlCreateButton("Chạy auto", 210, 388, 94, 25, $style)
		Case $AutoLadder
			$AutoLadderButton = GUICtrlCreateButton("Chạy auto", 210, 388, 94, 25, $style)
		Case $AutoZombieWinMulti
			$AutoZombieWinButton = GUICtrlCreateButton("Chạy auto", 210, 388, 94, 25, $style)
		Case $MiniAuto
			$LadderCalc = GUICtrlCreateButton("Tính điểm siêu cấp", 60, 415, 200, 25, $style)
		Case $AutoMore
			$WindowRenameButton = GUICtrlCreateButton("Đổi tên", 24, 150, 70, 25, $style)
	EndSwitch
EndFunc

Func DefaultPushButtonByTab()
	Switch $ActiveTab
		Case $AutoWho
			GUISwitch($MainGUI, $TabSheetWin)
			GUICtrlDelete($AutoWinButton)
			GUIButtonCreate($ActiveTab, True)
			GUICtrlCreateTabItem("")
			GUICtrlSetState($TabSheetWin, $GUI_SHOW)
		Case $AutoNeedle
			GUISwitch($MainGUI, $TabSheetNeedle)
			GUICtrlDelete($AutoNeedleButton)
			GUIButtonCreate($ActiveTab, True)
			GUICtrlCreateTabItem("")
			GUICtrlSetState($TabSheetNeedle, $GUI_SHOW)
		Case $AutoEXP
			GUISwitch($MainGUI, $TabSheetEXP)
			GUICtrlDelete($AutoEXPButton)
			GUIButtonCreate($ActiveTab, True)
			GUICtrlCreateTabItem("")
			GUICtrlSetState($TabSheetEXP, $GUI_SHOW)
		Case $AutoLadder
			GUISwitch($MainGUI, $TabSheetLadder)
			GUICtrlDelete($AutoLadderButton)
			GUIButtonCreate($ActiveTab, True)
			GUICtrlCreateTabItem("")
			GUICtrlSetState($TabSheetLadder, $GUI_SHOW)
		Case $AutoZombieWinMulti
			GUISwitch($MainGUI, $TabSheetZombieWinMulti)
			GUICtrlDelete($AutoZombieWinButton)
			GUIButtonCreate($ActiveTab, True)
			GUICtrlCreateTabItem("")
			GUICtrlSetState($TabSheetZombieWinMulti, $GUI_SHOW)
		Case $MiniAuto
			GUISwitch($MainGUI, $TabSheetMiniAuto)
			GUICtrlDelete($LadderCalc)
			GUIButtonCreate($ActiveTab, True)
			GUICtrlCreateTabItem("")
			GUICtrlSetState($TabSheetMiniAuto, $GUI_SHOW)
		Case $AutoMore
			GUISwitch($MainGUI, $TabSheetMore)
			GUICtrlDelete($WindowRenameButton)
			GUIButtonCreate($ActiveTab, True)
			GUICtrlSetData($WindowRenameResult, 'Nhập tên cửa sổ hiện tại và chọn lệnh tương ứng.')
			GUICtrlCreateTabItem("")
			GUICtrlSetState($TabSheetMore, $GUI_SHOW)
	EndSwitch
EndFunc

Func SplashSet($text = "")
	GUISwitch($splashwindow)
	If Not GUICtrlSetData($splashstatic, $text) Then
		$splashwindow = GUICreate($autoname, 300, 135, @DesktopWidth - 310 - $buffer, 10, 0)
		GUIFont()
		$splashstatic = GUICtrlCreateLabel($text, 0, 0, 300, 135, 1)
		WinSetTrans($splashwindow, "", 0)
		GUISetState(@SW_SHOW, $splashwindow)
		Return WinFade($splashwindow, "", 0, 200, 25)
	EndIf
EndFunc

Func CreateHelpGUI($text = "", $iFlag = True)
	$HelpGUI = GUICreate($autoname, 320, $GUIHeight, -1, -1, -1, -1, $iFlag ? $MainGUI : 0)
	WinSetTrans($HelpGUI, "", 225)
	RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "DejaVu Sans (TrueType)")
	@error ? GUIFont() : GUISetFont(9, 0, 0, "DejaVu Sans")
	GUICtrlCreateEdit($text, 0, 0, 320, $GUIHeight, 0x00200804)
	WinSetTrans($HelpGUI, "", 0)
	GUISetState(@SW_SHOW, $HelpGUI)
	WinFade($HelpGUI, "", 0, 225, 25)
	Do
	Until GUIGetMsg() = -3
	WinFade($HelpGUI, "", 225, 0, -25)
	Return GUIDelete($HelpGUI)
EndFunc

Func _DebugLine($text = "", Const $line = @ScriptLineNumber)
	Return _DebugOut((@Compiled ? "" : ($line & ": ")) & $text)
EndFunc

Func MarketResult($success)
	Switch $success
		Case 1
			Return "Đã mua vật phẩm"
		Case 2
			Return "Không thể mua vật phẩm"
		Case 3
			Return "Không tìm thấy vật phẩm theo yêu cầu"
		Case 4
			Return "Bạn đang sở hữu vật phẩm cần tìm"
	EndSwitch
	Return ""
EndFunc

Func GUIChannels($checkbox, $combo)
	Return GUICtrlSetData($combo, NormalChannels(GUICtrlRead($checkbox)), "TD-07")
EndFunc

Func NormalChannels($ServerHN)
	Return "|TD-01|TD-02|TD-03|TD-04|TD-05|TD-06|TD-07|TD-08|TD-09" & _
			(($ServerHN = 1) ? "" : "|TD-10|TD-11|TD-12|TD-13|TD-14")
EndFunc

Func LadderChannels($ServerHN)
	Return "|LT-01|LT-02|CB-01" & (($ServerHN = 1) ? "" : "|CB-02") & "|TD-01|TD-02|TD-03|TD-04" & (($ServerHN = 1) ? "" : "|TD-05|TD-06")
EndFunc

Func AssignChannel($Channel)
	Switch $ActiveTab
		Case $AutoLadder
			If $svrHN = 1 Then
				Switch $Channel
					Case "TD-03"
						$chanx = 513
						$chany = 301
					Case "TD-04"
						$chanx = 681
						$chany = 301
					Case "LT-01"
						$chanx = 681
						$chany = 357
					Case "LT-02"
						$chanx = 513
						$chany = 414
					Case "CB-01"
						$chanx = 681
						$chany = 414
					Case "TD-01"
						$chanx = 513
						$chany = 470
					Case "TD-02"
						$chanx = 681
						$chany = 470
				EndSwitch
				$ChannelPage = ((StringInStr($Channel, "TD-") And Number(StringRight($Channel, 2)) > 2) ? 2 : 1)
			Else
				Switch $Channel
					Case "TD-02"
						$chanx = 513
						$chany = 301
					Case "TD-03"
						$chanx = 681
						$chany = 301
					Case "TD-04"
						$chanx = 513
						$chany = 357
					Case "LT-01", "TD-05"
						$chanx = 681
						$chany = 357
					Case "LT-02", "TD-06"
						$chanx = 513
						$chany = 414
					Case "CB-01"
						$chanx = 681
						$chany = 414
					Case "CB-02"
						$chanx = 513
						$chany = 470
					Case "TD-01"
						$chanx = 681
						$chany = 470
				EndSwitch
				$ChannelPage = ((StringInStr($Channel, "TD-") And Number(StringRight($Channel, 2)) > 1) ? 2 : 1)
			EndIf
			$TownInChannel = True
		Case Else
			Switch $Channel
				Case "TD-01"
					$chanx = 513
					$chany = 301
				Case "TD-02"
					$chanx = 681
					$chany = 301
				Case "TD-03", "TD-09"
					$chanx = 513
					$chany = 357
				Case "TD-04", "TD-10"
					$chanx = 681
					$chany = 357
				Case "TD-05", "TD-11"
					$chanx = 513
					$chany = 414
				Case "TD-06", "TD-12"
					$chanx = 681
					$chany = 414
				Case "TD-07", "TD-13"
					$chanx = 513
					$chany = 470
				Case "TD-08", "TD-14"
					$chanx = 681
					$chany = 470
			EndSwitch
			$TownInChannel = Not Mod(Number(StringRight($Channel, 2)), 2) Or True
			$ChannelPage = (Number(StringRight($Channel, 2)) > 8 ? 2 : 1)
	EndSwitch
EndFunc

Func Timer($time)
	AdlibUnRegister("KillAndRefresh")
	Switch $ActiveTab
		Case $AutoWho To $AutoLadder
			$timer = $time
			If $time >= 0 Then
				AdlibRegister("KillAndRefresh", $time)
				$wait = TimerInit()
				_DebugReportVar("Created timer", $time)
			Else
				_DebugLine("Killed previous timer.")
			EndIf
	EndSwitch
EndFunc

Func PeriodicDisCheck($iFlag)
	$PeriodicCheck = $iFlag
	Switch $ActiveTab
		Case $AutoWho To $AutoLadder
			$iFlag ? AdlibRegister("CheckDis", 10000) : AdlibUnRegister("CheckDis")
			$iFlag ? _DebugLine("PeriodicDisCheck() engaged.") : _DebugLine("PeriodicDisCheck() disengaged.")
	EndSwitch
EndFunc

Func KillTimers()
	PeriodicDisCheck(False)
	Return Timer(-1)
EndFunc

Func LadderLoops()
	Return ("Số vòng lặp auto đã chạy: " & $LadderWins & "/" & $autoloops)
EndFunc

Func FullShortcutCommand()
	Return ((@Compiled And StringUpper(StringRight(@ScriptFullPath, 4)) = ".EXE") ? ('"' & @ScriptFullPath & '"') : _
			('"' & @AutoItExe & '" "' & @ScriptFullPath & '"')) & ' ' & CommandLine(True)
EndFunc

Func GUIFont()
	RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "Sans-Serif Latin Regular (TrueType)")
	If Not @error Then Return GUISetFont(9, 0, 0, "Sans-Serif Latin")
	RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "Segoe UI (TrueType)")
	If Not @error Then Return GUISetFont(9, 0, 0, "Segoe UI")
	Return GUISetFont(8.5, 0, 0, "Tahoma")
EndFunc

Func WhoModeFromGUI()
	Local $i = 0
	For $name In $AutoWhoMode
		If GUICtrlRead($WhoModeSelect) == $name Then Return $i
		$i += 1
	Next
	#cs ;let's practice the For-In-Next loop!
	For $i = 0 To UBound($AutoWhoMode) - 1
		If GUICtrlRead($WhoModeSelect) == $AutoWhoMode[$i] Then Return $i
	Next
	#ce
	Return 0
EndFunc

Func ExpModeFromGUI()
	Local $i = 0
	For $name In $ZombieMode
		If GUICtrlRead($name) = 1 Then Return $i
		$i += 1
	Next
	#cs ;let's practice the For-In-Next loop again!
	For $i = 0 To UBound($ZombieMode) - 1
		If GUICtrlRead($ZombieMode[$i]) = 1 Then Return $i
	Next
	#ce
	Return 0
EndFunc

Func PowerKeepAlive()
	#cs
		; Flags:
		;	ES_SYSTEM_REQUIRED  (0x01) -> Resets system Idle timer
		;	ES_DISPLAY_REQUIRED (0x02) -> Resets display Idle timer
		;	ES_CONTINUOUS (0x80000000) -> Forces 'continuous mode' -> the above 2 will not need to continuously be reset
	#ce
	Local $aRet = DllCall('kernel32.dll', 'long', 'SetThreadExecutionState', 'long', 0x80000003)
	;If @error Then Return SetError(2, @error, 0x80000000)
	;Return $aRet[0]	; Previous state (typically 0x80000000 [-2147483648])
EndFunc

Func PowerResetState()
	AdlibUnRegister("PowerKeepAlive")
	; Flag:	ES_CONTINUOUS (0x80000000) -> (default) -> used alone, it resets timers & allows regular sleep/power-savings mode
	Local $aRet = DllCall('kernel32.dll', 'long', 'SetThreadExecutionState', 'long', 0x80000000)
	;If @error Then Return SetError(2, @error, 0x80000000)
	;Return $aRet[0]	; Previous state
EndFunc

Func Out()
	Exit WinFade($splashwindow, "", 200, 0, -25)
EndFunc

Func OnExit()
	InetClose($download)
	FileSetAttrib("AutoBoom-TDStoneheart-Settings.txt", "-H")
	$configfile = FileOpen("AutoBoom-TDStoneheart-Settings.txt", 2 + 256)
	FileWriteLine($configfile, "AutoBoom-TDStoneheart / Settings")
	FileWriteLine($configfile, "")
	FileWriteLine($configfile, StringFormat("%.2f", $version))
	FileWriteLine($configfile, $ActiveTab)
	FileWriteLine($configfile, $DefaultRoomName)
	FileWriteLine($configfile, Bit($DebugMode))
	FileWriteLine($configfile, Bit($DebugModeFlag))
	FileWriteLine($configfile, Bit($CheckForUpdates))
	FileFlush($configfile)
	FileSetAttrib("AutoBoom-TDStoneheart-Settings.txt", "+H")
	Return FileDelete(@TempDir & "\AutoBoom-TDStoneheart.txt")
EndFunc

Func ConfigFileRead()
	$configfile = FileOpen("AutoBoom-TDStoneheart-Settings.txt", 256)
	If $configfile <> -1 Then
		FileReadLine($configfile)
		FileReadLine($configfile)
		$localver = Number(FileReadLine($configfile))
		$ActiveTab = Number(FileReadLine($configfile))
		$DefaultRoomName = StringLeft(FileReadLine($configfile), 22)
		$DebugMode = Number(FileReadLine($configfile))
		$DebugModeFlag = Number(FileReadLine($configfile))
		$CheckForUpdates = Number(FileReadLine($configfile))
		Return FileClose($configfile)
	EndIf
EndFunc

Func KillAll()
	Local $time = TimerInit(), $wnd, $matched
	While WinClose("ca.exe - Application Error")
		Sleep(100)
	WEnd
	;WinMinimizeAll()
	AutoItSetOption("WinTitleMatchMode", 1)
	Do
		If $ActiveTab <> 1 Then $matched = True
		For $i = 1 To (($ActiveTab = 1) ? 1 : $windows)
			If $ActiveTab = 1 Then
				If Not WinExists("Boom") Then
					ExitLoop 2
				ElseIf WinExists("b" & $i) Then
					ContinueLoop
				EndIf
			EndIf
			$wnd = (($ActiveTab = 1) ? "Boom" : ("b" & $i))
			WinClose($wnd)
			WinKill($wnd)
			If WinActivate($wnd) Then Send("!{F4}")
			While WinClose("Visual Studio Just-In-Time Debugger", "ca.exe")
				Sleep(100)
			WEnd
			If WinSetState("Crazy Arcade Client", "", @SW_SHOW) Then
				For $attempt = 1 To 10
					If Not ControlClick("Crazy Arcade Client", "", "Button1", "main") Then ExitLoop
					Sleep(50)
				Next
			EndIf
			If $ActiveTab <> 1 And WinExists("b" & $i) Then $matched = False
		Next
	Until (($ActiveTab = 1) ? Not WinExists("Boom") : $matched)
	;WinMinimizeAllUndo()
	AutoItSetOption("WinTitleMatchMode", 3)
	Return TimerDiff($time)
EndFunc
#EndRegion AuxiliaryFunctions

Func NewWindow($wnd = "Boom")
	_DebugLine("NewWindow() started.")
	Local $version = 0, $attempt = 0
	$path = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "CAPath")
	If @error Then
		MsgBox(16, "Không thể tạo cửa sổ", "Mở Boom bằng tay một lần rồi thoát và chạy lại auto.")
		Return BackToGUI()
	ElseIf FileExists($path & "\xtcmulti2.3.exe") Then
		$version = 2.3
	ElseIf FileExists(@HomeDrive & "\XTCv26\xtcmulti2.0.exe") Then
		$version = 2.0
	ElseIf FileExists(@HomeDrive & "\XTC Multi\xtcmulti2.1.exe") Then
		$version = 2.1
	EndIf
	If WinExists("[TITLE:Boom; CLASS:Crazy Arcade]") And BitAND(WinGetState("[TITLE:Boom; CLASS:Crazy Arcade]"), 2) Then
		WinActivate("[TITLE:Boom; CLASS:Crazy Arcade]")
		While $wnd <> "Boom" And Not WinSetTitle("[TITLE:Boom; CLASS:Crazy Arcade]", "", $wnd)
			_DebugLine("Renaming window")
			Sleep(100)
		WEnd
		Return _DebugReportVar("Renamed existing window", $wnd)
	EndIf
	While 1
		If $attempt >= 3 Then
			_DebugLine("New window creation failed " & $attempt & " times in a row! Renewing IP address...")
			_DebugLine("Returned " & RunWait("ipconfig.exe /renew", "", @SW_HIDE, 0x10000) & ".")
			$attempt = 0
		EndIf
		$attempt += 1
		If ($windows = 1) Or ($ActiveTab = $AutoNeedle) Then
			Run($path & '\ca.exe' & (($svrHN = 1) ? ' svrHN' : ''))
		Else
			Switch $version
				Case 2.3
					If Not WinExists("[CLASS:Ta6]", "Hà Nội") Then
						Run($path & "\xtcmulti2.3.exe", $path, @SW_MINIMIZE)
						If @error Then
							MsgBox(16, "Không thể tạo cửa sổ", "Chưa cài đặt XTC Multi 2.0 trở lên.")
							Return BackToGUI()
						EndIf
						_DebugLine("Opening XTC Multi 2.3...")
						WinWait("[TITLE:Notice; CLASS:#32770]", "XTC Multi 2.")
					EndIf
				Case 2.0, 2.1
					If Not (WinExists("[TITLE:Notice; CLASS:#32770]", $version = 2.1 ? "XTC Multi 2.1" : "XTC Multi 2.0") Or _
							WinExists($version = 2.1 ? "[TITLE:v2.1; CLASS:TForm1]" : "[TITLE:XTC Multi 2.0; CLASS:TForm1]")) Then
						($version = 2.1) ? Run(@HomeDrive & "\XTC Multi\xtcmulti2.1.exe", @HomeDrive & "\XTC Multi", @SW_MINIMIZE) : _
								Run(@HomeDrive & "\XTCv26\xtcmulti2.0.exe", @HomeDrive & "\XTCv26", @SW_MINIMIZE)
						If @error Then
							MsgBox(16, "Không thể tạo cửa sổ", "Chưa cài đặt XTC Multi 2.0 trở lên.")
							Return BackToGUI()
						EndIf
						_DebugLine($version = 2.1 ? "Opening XTC Multi 2.1..." : "Opening XTC Multi 2.0...")
						WinWait("[TITLE:Notice; CLASS:#32770]", "XTC Multi 2.")
					EndIf
				Case Else
					MsgBox(16, "Không thể tạo cửa sổ", "Chưa cài đặt XTC Multi 2.0 trở lên.")
					Return BackToGUI()
			EndSwitch
			While WinClose("[TITLE:Notice; CLASS:#32770]", "XTC Multi 2.")
				Sleep(100)
			WEnd
			_DebugLine('"Notice" window closed.')
			Do
				If WinExists("[CLASS:Ta6]", "Hà Nội") Then
					WinSetState("[CLASS:Ta6]", "Hà Nội", @SW_MINIMIZE)
					_DebugLine('XTC Multi 2.3 opened and minimized.')
					ExitLoop
				ElseIf WinExists($version = 2.1 ? "[TITLE:v2.1; CLASS:TForm1]" : "[TITLE:XTC Multi 2.0; CLASS:TForm1]") Then
					WinSetState($version = 2.1 ? "[TITLE:v2.1; CLASS:TForm1]" : "[TITLE:XTC Multi 2.0; CLASS:TForm1]", "", @SW_MINIMIZE)
					_DebugLine(($version = 2.1 ? '"XTC Multi 2.1"' : '"XTC Multi 2.0"') & ' opened and minimized.')
					ExitLoop
				ElseIf WinExists("Lỗi", _
						"Không thể phát hiện thư mục Boom, hãy vào Boom và thoát ra sau đó bật lại chương trình.") Then
					While WinClose("Lỗi", _
							"Không thể phát hiện thư mục Boom, hãy vào Boom và thoát ra sau đó bật lại chương trình.")
						Sleep(100)
					WEnd
					MsgBox(16, "Không thể tạo cửa sổ", "Mở Boom bằng tay một lần rồi thoát và chạy lại auto.")
					Return BackToGUI()
				EndIf
			Until Not Sleep(100)
			If $svrHN = 1 Then
				If $version >= 2.3 Then
					ControlClick("[CLASS:Ta6]", "Hà Nội", "[CLASS:TAdvGlowButton; INSTANCE:1]", "main")
					Sleep(2000)
					ControlClick("[CLASS:Ta6]", "Hà Nội", "[CLASS:TAdvGlowButton; INSTANCE:1]", "main")
					Sleep(2000)
					ControlClick("[CLASS:Ta6]", "Hà Nội", "[CLASS:TAdvGlowButton; INSTANCE:1]", "main")
				Else
					ControlClick($version = 2.1 ? "[TITLE:v2.1; CLASS:TForm1]" : "[TITLE:XTC Multi 2.0; CLASS:TForm1]", _
							"Hà Nội", "[CLASS:TAdvGlowButton; INSTANCE:1]", "main")
				EndIf
				_DebugLine('Opening "ca.exe" (svrHN)...')
			Else ;$svrHN = 4
				If $version >= 2.3 Then
					ControlClick("[CLASS:Ta6]", "Hà Nội", "[CLASS:TAdvGlowButton; INSTANCE:2]", "main")
					Sleep(2000)
					ControlClick("[CLASS:Ta6]", "Hà Nội", "[CLASS:TAdvGlowButton; INSTANCE:2]", "main")
					Sleep(2000)
					ControlClick("[CLASS:Ta6]", "Hà Nội", "[CLASS:TAdvGlowButton; INSTANCE:2]", "main")
				Else
					ControlClick($version = 2.1 ? "[TITLE:v2.1; CLASS:TForm1]" : "[TITLE:XTC Multi 2.0; CLASS:TForm1]", _
							"Hồ Chí Minh", "[CLASS:TAdvGlowButton; INSTANCE:2]", "main")
				EndIf
				_DebugLine('Opening "ca.exe" (svrHCM)...')
			EndIf
		EndIf
		Do
			Select
				Case Not ProcessExists("ca.exe")
					_DebugLine('Process does not exist!')
					ExitLoop
				Case WinExists("ca.exe - Application Error")
					While WinClose("ca.exe - Application Error")
						Sleep(100)
					WEnd
					_DebugLine('"Application Error" windows closed.')
					ExitLoop
				Case WinExists("Error", "NMCO")
					While WinClose("Error", "NMCO")
						Sleep(100)
					WEnd
					_DebugLine('NMCO Error windows closed.')
				Case WinExists("Error!", "NMCO")
					While WinClose("Error!", "NMCO")
						Sleep(100)
					WEnd
					_DebugLine('NMCO "Error!" windows closed.')
				Case WinExists("WinLicense", "Sorry, this application cannot run under a Virtual Machine")
					While WinClose("WinLicense", "Sorry, this application cannot run under a Virtual Machine")
						Sleep(100)
					WEnd
					_DebugLine('"WinLicense" (virtual machine notification) windows closed.')
				Case WinExists("[TITLE:Boom Online - AutoUpdate; CLASS:BMLauncher]")
					_DebugLine("Updater running!")
					GUISwitch($splashwindow)
					$lastsplashtext = GUICtrlRead($splashstatic)
					SplashSet("Boom đang cập nhật" & @CRLF & "Đang chờ cập nhật hoàn thành" & @CRLF & _
							"Ctrl+F7: Tạm dừng - Ctrl+F9: Thoát" & @CRLF & _
							"Ctrl+F12: Dừng && trở về giao diện chọn auto")
					While WinExists("[TITLE:Boom Online - AutoUpdate; CLASS:BMLauncher]")
						$timinghandle = TimerInit()
						WinSetOnTop("[TITLE:Boom Online - AutoUpdate; CLASS:BMLauncher]", "", 1)
						WinActivate("[TITLE:Boom Online - AutoUpdate; CLASS:BMLauncher]")
						MouseClick("main", 817, 145, 2, 0)
						WinSetOnTop("[TITLE:Boom Online - AutoUpdate; CLASS:BMLauncher]", "", 0)
						While TimerDiff($timinghandle) < 1000
							Sleep(100)
						WEnd
					WEnd
					#cs
					While Not StringInStr(WinGetText("[CLASS:#32770]"), "thành công")
						If StringInStr(WinGetText("[CLASS:#32770]"), "thất bại") Then
							;ControlClick("[CLASS:#32770]", "", "[CLASS:Button; INSTANCE:3]", "main")
							While WinClose("[TITLE:Boom Online - AutoUpdate; CLASS:BMLauncher]")
								Sleep(100)
							WEnd
							ContinueLoop 3
						EndIf
						Sleep(1000)
					WEnd
					While WinClose("[TITLE:Boom Online - AutoUpdate; CLASS:BMLauncher]")
						Sleep(100)
					WEnd
					#ce
					SplashSet($lastsplashtext)
					ExitLoop
				Case WinExists("Chú Ý", "Hãy tắt hết Boom và bấm F2 lại. Nếu vẫn hiện thông báo này hãy tắt Auto và bật lại.")
					WinClose("Chú Ý", "Hãy tắt hết Boom và bấm F2 lại. Nếu vẫn hiện thông báo này hãy tắt Auto và bật lại.")
					_DebugLine("Single normal window exists.")
					If MsgBox(16 + 4, "Không thể tạo cửa sổ mới", "Bạn có muốn thoát mọi cửa sổ Boom đang chạy không?" & _
							@CRLF & "Nếu không, bạn sẽ quay trở về giao diện chọn auto.") = 6 Then
						KillAll()
						ExitLoop
					Else
						Return BackToGUI()
					EndIf
				Case WinExists("Kết nối thất bại.")
					While WinClose("Kết nối thất bại.")
						Sleep(100)
					WEnd
					_DebugLine('"Login failed" (Vietnamese) windows closed.')
					ExitLoop
				Case WinExists("Login Failed")
					While WinClose("Login Failed")
						Sleep(100)
					WEnd
					_DebugLine('"Login Failed" windows closed.')
					ExitLoop
				Case WinExists("login fail")
					While WinClose("login fail")
						Sleep(100)
					WEnd
					_DebugLine('"login fail" windows closed.')
					ExitLoop
				Case WinExists("ErrCannotLoginCaption", "ErrCannotLogin")
					While WinClose("ErrCannotLoginCaption", "ErrCannotLogin")
						Sleep(100)
					WEnd
					_DebugLine('"ErrCannotLoginCaption" windows closed.')
					ExitLoop
				Case WinExists("CrashDlg")
					While WinExists("CrashDlg")
						WinKill("CrashDlg")
						Sleep(100)
					WEnd
					_DebugLine('"CrashDlg" windows closed.')
					ExitLoop
				Case WinExists("Error", "HS_")
					While WinClose("Error", "HS_")
						Sleep(100)
					WEnd
					_DebugLine('"Error" ("HS_*") windows closed.')
					ExitLoop
				Case WinExists("Error", "mainDisconnected")
					While WinClose("Error", "mainDisconnected")
						Sleep(100)
					WEnd
					_DebugLine('"Error" ("mainDisconnected") windows closed.')
					ExitLoop
				Case WinExists("Crazy Arcade Client")
					While WinClose("Crazy Arcade Client")
						Sleep(100)
					WEnd
					_DebugLine('"Crazy Arcade Client" (has stopped working) windows closed.')
					ExitLoop
				Case WinExists("[TITLE:Boom; CLASS:Crazy Arcade]")
					If BitAND(WinGetState("[TITLE:Boom; CLASS:Crazy Arcade]"), 2) Then
						WinActivate("[TITLE:Boom; CLASS:Crazy Arcade]")
						While $wnd <> "Boom" And Not WinSetTitle("[TITLE:Boom; CLASS:Crazy Arcade]", "", $wnd)
							_DebugLine("Renaming window")
							Sleep(100)
						WEnd
						ExitLoop 2
					EndIf
			EndSelect
		Until Not Sleep(100)
	WEnd
	Return _DebugReportVar("Completed creating window", $wnd)
EndFunc

Func PostLogin($wnd, $pl1, $pass1, $pl2, $pass2)
	_DebugLine("PostLogin() started.")
	While MouseAway()
		Timer(-1)
		Timer(40000)
		_DebugLine("Waiting for login screen...")
		While PixelGetColor(384, 580, WinGetHandle($wnd)) <> 0x25B1FA
			If PixelGetColor(552, 274, WinGetHandle($wnd)) = 0x0CDFFF Then
				_DebugLine("Notification popped up. (Can't Connect To Login Server?)")
				ControlSend($wnd, "", "", "{esc}")
				While WinClose("login fail", "Can't Connect")
					Sleep(100)
				WEnd
				While WinClose("Kết nối thất bại.")
					Sleep(100)
				WEnd
				WinKill($wnd)
				WinWaitClose($wnd)
				RunAuto()
			EndIf
			#cs ;remedy for full-screen (w/o registry modification)
			While @DesktopWidth = 800 And @DesktopHeight = 600
				ControlSend($wnd, "", "", "!{enter}")
				Sleep(3000)
			WEnd
			#ce
			Sleep(100)
			ControlClick($wnd, "", "", "main", 1, 0, 0)
		WEnd
		_DebugLine("Login screen fully appeared.")
		If $pl2 = "" Then
			ControlClick($wnd, "", "", "main", 2, 210, 482)
			ControlClick($wnd, "", "", "main", 2, 428, 472)
			SendKeepActive($wnd)
			Send("{BS 12}")
			Send($pl1, 1)
			Send("{TAB}")
			Send($pass1, 1)
			Send("{ENTER}")
			SendKeepActive("")
			_DebugLine("Logging in 1 player...")
		Else
			ControlClick($wnd, "", "", "main", 2, 588, 482)
			ControlClick($wnd, "", "", "main", 2, 428, 472)
			SendKeepActive($wnd)
			Send("{BS 12}")
			Send($pl1, 1)
			Send("{TAB}")
			Send($pass1, 1)
			Send("{TAB}")
			Send($pl2, 1)
			Send("{TAB}")
			Send($pass2, 1)
			Send("{ENTER}")
			SendKeepActive("")
			_DebugLine("Logging in 2 players...")
		EndIf
		Sleep(1000)
		_DebugLine("Logging in...")
		While Sleep(10)
			If PixelChecksum(305, 193, 502, 231, 2, WinGetHandle($wnd)) = 4198154458 Then ContinueLoop ;still loading!
			If PixelGetColor(775, 590, WinGetHandle($wnd)) = 0xFF5B36 Then
				ExitLoop
			ElseIf PixelGetColor(551, 289, WinGetHandle($wnd)) = 0x0CDFFF Then
				_DebugLine("Some notification popped up!")
				Do
					ControlSend($wnd, "", "", "{ENTER}")
					Sleep(100)
					If PixelGetColor(384, 580, WinGetHandle($wnd)) = 0x25B1FA Then ContinueLoop 3
				Until PixelGetColor(775, 590, WinGetHandle($wnd)) = 0xFF5B36
			ElseIf PixelGetColor(491, 406, WinGetHandle($wnd)) = 0x00B1FD Then
				_DebugLine("Same ID logged in!")
				Do
					ControlSend($wnd, "", "", "{ENTER 2}")
					Sleep(5000)
				Until PixelGetColor(775, 590, WinGetHandle($wnd)) = 0xFF5B36
			ElseIf PixelGetColor(384, 580, WinGetHandle($wnd)) = 0x25B1FA Then
				Sleep(500)
				If PixelGetColor(384, 580, WinGetHandle($wnd)) = 0x25B1FA Then
					_DebugLine("Back to login screen.")
					WinKill($wnd)
					WinWaitClose($wnd)
					RunAuto()
				EndIf
			EndIf
		WEnd
		Timer(-1)
		_DebugLine("Login complete!")
		Timer(30000)
		If $ActiveTab <> $AutoLadder Then
			Do
				ControlClick($wnd, "", "", "main", 1, 517 - 2, 202 - 23)
				Sleep(10)
			Until PixelGetColor(539, 156, WinGetHandle($wnd)) = 0xBB0F18
			_DebugLine("Normal mode selected.")
			While PixelGetColor(513, 470, WinGetHandle($wnd)) = 0x09A0F4 And PixelGetColor(539, 156, WinGetHandle($wnd)) = 0xBB0F18
				ControlClick($wnd, "", "", "main", 1, 605 - 2, 57 - 23)
				Sleep(100)
				Do
					ControlClick($wnd, "", "", "main", 1, 517 - 2, 202 - 23)
					Sleep(10)
				Until PixelGetColor(539, 156, WinGetHandle($wnd)) = 0xBB0F18
				_DebugLine("Getting out of Hidden Catch mode...")
			WEnd
		Else
			While PixelGetColor(513, 470, WinGetHandle($wnd)) = 0x09A0F4 And PixelGetColor(539, 156, WinGetHandle($wnd)) = 0xBB0F18
				ControlClick($wnd, "", "", "main", 1, 605 - 2, 57 - 23)
				Sleep(100)
				ControlClick($wnd, "", "", "main", 1, 597, 187)
				Sleep(10)
				_DebugLine("Getting out of Hidden Catch mode...")
			WEnd
			Do
				ControlClick($wnd, "", "", "main", 1, 597, 187)
				Sleep(10)
			Until PixelGetColor(597, 187, WinGetHandle($wnd)) = 0xFCC08B
			_DebugLine("Ladder mode selected.")
		EndIf
		Timer(-1)
		ControlClick($wnd, "", "", "main", 2, 535 - 30 + (30 * $ChannelPage), 527)
		_DebugReportVar("Channel page number", $ChannelPage)
		Timer(30000)
		While 1
			ControlSend($wnd, "", "", "{ENTER}")
			Sleep(100)
			ControlClick($wnd, "", "", "main", 2, $chanx, $chany)
			_DebugReportVar("Channel selected", $ChannelName)
			Do
				If PixelGetColor(319, 277, WinGetHandle($wnd)) = 0x9FFCFE Or _
						(PixelGetColor(775, 590, WinGetHandle($wnd)) = 0xFF5B36 And _
						PixelGetColor(166, 581, WinGetHandle($wnd)) = 0xFFFFFF) Then
					Timer(-1)
					_DebugLine("Connecting to selected channel...")
					ExitLoop 3
				ElseIf PixelGetColor(384, 580, WinGetHandle($wnd)) = 0x25B1FA Then
					_DebugLine("Back to login screen.")
					ExitLoop 2
				ElseIf PixelGetColor(552, 274, WinGetHandle($wnd)) = 0x0CDFFF Then
					_DebugLine("Notification pops up (probably temporarily unable to connect to channel).")
					ExitLoop 1
				EndIf
			Until Not Sleep(10)
		WEnd
	WEnd
	Return _DebugLine("PostLogin() completed.")
EndFunc

Func SelectMap($wnd = "b1")
	_DebugLine("SelectMap() started.")
	Local $mapy = 0, $mapcolor = 0, $submap = 0, $dir = False ;downward direction
	MouseAway()
	WinActivate($wnd)
	Timer(30000)
	While 1
		ControlClick($wnd, "", "", "main", 2, 713, 453)
		Sleep(10)
		If PixelGetColor(623, 331, WinGetHandle($wnd)) = 0x0CDFFF Then
			_DebugLine("Map selection window popped up (no custom random option).")
			$nocustomrandom = 38
			ExitLoop
		ElseIf PixelGetColor(661, 333, WinGetHandle($wnd)) = 0x0CDFFF Then
			_DebugLine("Map selection window popped up (with custom random option).")
			$nocustomrandom = 0
			ExitLoop
		EndIf
	WEnd
	Timer(-1)
	Timer(30000)
	If $ActiveTab = $AutoWho And $whomode = 1 And 0 Then
		_DebugLine("Scrolling to the first map page.")
		While Not (PixelGetColor(640 - $nocustomrandom, 200, WinGetHandle($wnd)) = 0x139DF3 Or _
				PixelGetColor(638 - $nocustomrandom, 185, WinGetHandle($wnd)) = 0x32B7FA)
			ControlClick($wnd, "", "", "main", 5, 640 - $nocustomrandom, 196)
			Sleep(10)
		WEnd
	EndIf
	Select
		Case $ActiveTab = $MiniAuto And $MoreMode = $AutoMoreQuestItem
			$mapcolor = 0x1A8200
			$submap = 13
		Case $ActiveTab = $AutoEXP
			Switch $expmode
				Case 0
					$mapcolor = 0xFFB000
					$submap = 2
				Case Else
					$mapcolor = 0x6CAA6C
					If $expmode <> 1 Then $submap = 5
			EndSwitch
		Case $ActiveTab = $AutoWho Or $ActiveTab = $AutoZombieWinMulti
			Switch $whomode
				Case 2
					$mapcolor = 0x6CAA6C
				Case 1
					;$mapy = 197
					;$submap = 1
					$mapcolor = 0xE89B0D
				Case Else
					$mapcolor = 0xE89B0D
			EndSwitch
	EndSelect
	_DebugReportVar("Map color", $mapcolor)
	_DebugReportVar("Sub-map", $submap)
	While 1 ; Not ($ActiveTab = $AutoWho And $whomode = 1)
		_DebugLine("Searching desired map through the page...")
		For $c = 183 To 463 Step 14
			If PixelGetColor(346 + $nocustomrandom, $c, WinGetHandle($wnd)) = $mapcolor Then
				$mapy = $c
				_DebugReportVar("Map Y", $mapy)
				ExitLoop
			EndIf
		Next
		If $mapy <> 0 Then ExitLoop
		ControlClick($wnd, "", "", "main", 1, 639 - $nocustomrandom, $dir ? 461 : 196)
		Sleep(100)
		If PixelGetColor(640 - $nocustomrandom, 460, WinGetHandle($wnd)) = 0x139DF3 Or _
				PixelGetColor(640 - $nocustomrandom, 200, WinGetHandle($wnd)) = 0x139DF3 Then
			_DebugReportVar("Searching direction downwards", $dir)
			$dir = Not $dir
		EndIf
	WEnd
	ControlClick($wnd, "", "", "main", 1, 461, $mapy)
	If $submap Then
		If $mapy + (14 * $submap) > 463 Then
			_DebugLine("Desired map exceeds current page.")
			For $c = 1 To $submap
				ControlClick($wnd, "", "", "main", 1, 639 - $nocustomrandom, 473)
				Sleep(100)
			Next
			ControlClick($wnd, "", "", "main", 1, 461, $mapy)
		Else
			_DebugLine("Desired map is in current page.")
			ControlClick($wnd, "", "", "main", 1, 461, $mapy + (14 * $submap))
		EndIf
	EndIf
	ControlSend($wnd, "", "", "{enter}")
	Timer(-1)
	Return _DebugLine("Map selected. SelectMap() completed.")
EndFunc

Func PersistentEvents($wnd)
	If PixelGetColor(239, 544, WinGetHandle($wnd)) = 0x058154 Then ;lucky star event
		ControlClick($wnd, "", "", "main", 1, 704, 546)
		ControlClick($wnd, "", "", "main", 1, 737, 546)
	EndIf
	If PixelGetColor(629, 520, WinGetHandle($wnd)) = 0x8E2612 Then ;heroes event
		ControlClick($wnd, "", "", "main", 1, 704, 537)
		ControlClick($wnd, "", "", "main", 1, 761, 536)
	EndIf
EndFunc

Func DismissAds($wnd, $Rooms = True)
	_DebugLine("DismissAds() started.")
	MouseAway()
	WinActivate($wnd)
	Timer(30000)
	Do
		PersistentEvents($wnd)
		ControlClick($wnd, "", "", "main", 1, 0, 0)
		ControlSend($wnd, "", "", "{enter}")
		If PixelGetColor(218, 515, WinGetHandle($wnd)) = 0x00487D Then
			If PixelGetColor(775, 590, WinGetHandle($wnd)) = 0xFF5B36 _
					And PixelGetColor(239, 545, WinGetHandle($wnd)) = 0x6EE7FC Then ExitLoop
		EndIf
		#cs
		If (PixelGetColor(40, 247, WinGetHandle($wnd)) = 0x90FF00 Or PixelGetColor(55, 238, WinGetHandle($wnd)) = 0x90FF00) And _
				PixelGetColor(775, 590, WinGetHandle($wnd)) = 0xFF5B36 And PixelGetColor(239, 545, WinGetHandle($wnd)) = 0x6EE7FC Then ExitLoop
		#ce
	Until Not Sleep(10)
	$timinghandle = TimerInit()
	Do
		;PersistentEvents($wnd)
		Switch PixelGetColor(550, 250, WinGetHandle($wnd))
			Case 0x08DFFF, 0x0CDFFF
				ControlClick($wnd, "", "", "main", 1, 0, 0)
				ControlSend($wnd, "", "", "{esc}")
				$timinghandle = TimerInit()
		EndSwitch
		If PixelGetColor(775, 590, WinGetHandle($wnd)) = 0xFF5B36 And PixelGetColor(239, 545, WinGetHandle($wnd)) = 0x6EE7FC Then
			_DebugLine("More pop-ups?")
		ElseIf PixelGetColor(384, 580, WinGetHandle($wnd)) = 0x25B1FA Or WinExists("login fail") Or WinExists("Kết nối thất bại.") Then
			_DebugLine("Login problem detected. Invoking CheckDis()...")
			CheckDis()
		ElseIf PixelGetColor(627, 30, WinGetHandle($wnd)) = 0xFFFF00 Then
			ControlClick($wnd, "", "", "main", 1, 765, 30)
			$timinghandle = TimerInit()
		Else
			ControlClick($wnd, "", "", "main", 1, 0, 0)
			ControlSend($wnd, "", "", "{enter}")
			$timinghandle = TimerInit()
		EndIf
		While PixelGetColor(273, 417, WinGetHandle($wnd)) <> 0x0EBAF7
			ControlClick($wnd, "", "", "main", 1, 0, 0)
			ControlSend($wnd, "", "", "{esc}")
			Sleep(10)
		WEnd
		Sleep(10)
	Until TimerDiff($timinghandle) >= 200
	_DebugLine("Exit button fully appeared.")
	If 0 Then
		If Not $TownInChannel Then
			_DebugLine("Dismissing pop-ups for townless channels...")
			While Sleep(10)
				If PixelGetColor(55, 238, WinGetHandle($wnd)) = 0x90FF00 Then
					_DebugLine("More pop-ups?")
					Sleep(500)
					If PixelGetColor(55, 238, WinGetHandle($wnd)) = 0x90FF00 Then ExitLoop
				ElseIf PixelGetColor(384, 580, WinGetHandle($wnd)) = 0x25B1FA Then
					_DebugLine("Unexpectedly taken back to login screen!")
					ReLogin()
				EndIf
				ControlSend($wnd, "", "", "{ENTER}")
			WEnd
		ElseIf $Rooms Then
			_DebugLine("Waiting for the room pane...")
			While Not (PixelGetColor(735, 10, WinGetHandle($wnd)) = 0x0EBAF7 Or PixelGetColor(302, 26, WinGetHandle($wnd)) = 0xFBA00E)
				Sleep(10)
			WEnd
			If PixelGetColor(735, 10, WinGetHandle($wnd)) = 0x0EBAF7 Then
				ControlClick($wnd, "", "", "main", 1, 735, 10)
				_DebugLine("Opening the room pane.")
				While Not PixelGetColor(302, 26, WinGetHandle($wnd)) = 0xFBA00E
					Sleep(10)
				WEnd
			EndIf
			_DebugLine("More pop-ups?")
			While PixelGetColor(775, 590, WinGetHandle($wnd)) <> 0xFF5B36
				ControlSend($wnd, "", "", "{ENTER}")
				Sleep(10)
				If PixelGetColor(384, 580, $wnd) = 0x25B1FA Then ReLogin()
			WEnd
		EndIf
	EndIf
	Timer(-1)
	_DebugLine('DismissAds() for "' & $wnd & '" completed.')
EndFunc

Func PushStart($wnd = "[CLASS:Crazy Arcade]")
	_DebugLine("PushStart() started. Waiting until player is inside room.")
	WinActivate($wnd)
	While PixelGetColor(211, 49, WinGetHandle($wnd)) <> 0x00C3F4
		Sleep(10)
	WEnd
	_DebugLine("Player inside room.")
	While 1
		ControlClick($wnd, "", "", "main", 2, 604, 520) ;start/ready button
		Sleep(10)
		If PixelGetColor(554, 265, WinGetHandle($wnd)) = 0x0CDFFF Then
			_DebugLine("Everyone not ready!")
			Do
				ControlClick($wnd, "", "", "main", 1, 409, 387) ;notification close
				Sleep(100)
			Until PixelGetColor(554, 265, WinGetHandle($wnd)) = 0x046CC8
		ElseIf PixelGetColor(554, 265, WinGetHandle($wnd)) <> 0x046CC8 Then
			_DebugLine("Game start! PushStart() completed.")
			ExitLoop
		EndIf
	WEnd
EndFunc

Func HotKeys($iFlag = True)
	Switch $ActiveTab
		Case $AutoNeedle
			If $iFlag Then
				HotKeySet("^{f10}", "AutoNeedleUndoSession")
				HotKeySet("^{f11}", "AutoNeedleSkipSession")
			Else
				HotKeySet("^{f10}")
				HotKeySet("^{f11}")
			EndIf
		Case $AutoLadder
			If $iFlag Then
				HotKeySet("!^d", "LadderCamp08")
				HotKeySet("!^t", "LadderBattleship14")
				HotKeySet("!^n", "LadderVillage10")
				HotKeySet("!^r", "LadderMapRandom")
				HotKeySet("!^a", "LadderMapAuto")
				For $c = 1 To 5
					HotKeySet("!^" & $c, "LadderMap0" & $c)
				Next
			Else
				HotKeySet("!^d")
				HotKeySet("!^t")
				HotKeySet("!^n")
				HotKeySet("!^r")
				HotKeySet("!^a")
				For $c = 1 To 5
					HotKeySet("!^" & $c)
				Next
			EndIf
	EndSwitch
	_DebugLine($iFlag ? "Mode-specific hot keys set." : "Mode-specific hot keys unset.")
EndFunc

Func PreAuto2()
	Local $start = 2
	Switch $ActiveTab
		Case $AutoLadder
			$start = 3
		Case $AutoZombieWinMulti
			If $HostMode <> 1 Then $start = 1
	EndSwitch
	If $InviteMode = 1 Then
		For $i = $start To $windows
			WinActivate("b" & $i)
			While PixelGetColor(484, 241, WinGetHandle("b" & $i)) <> 0x0450A3
				Switch $ActiveTab
					Case $AutoWho
						For $c = $i To $windows
							ControlSend("b1", "", "", "!" & $c & "{enter 3}")
						Next
					Case $AutoLadder
						For $c = 1 To $windows - 2
							ControlSend("b" & $c, "", "", "!1{enter 3}")
						Next
				EndSwitch
				For $c = $i To $windows
					ControlSend("b" & $c, "", "", "{enter 2}")
				Next
				Sleep(10)
			WEnd
		Next
		Return _DebugLine("PreAuto2() completed.")
	EndIf
	For $i = $start To $windows
		WinActivate("b" & $i)
		Do
			Timer(30000)
			If ($ActiveTab = $AutoWho And $whomode = 0) Or ($ActiveTab = $AutoLadder) Then
				While PixelGetColor(567, 55, WinGetHandle("b" & $i)) <> 0x0DDFFF
					For $c = $i To $windows
						ControlSend("b" & $c, "", "", "!1{enter 2}")
					Next
					Sleep(10)
				WEnd
			Else
				SendKeepActive("b" & $i)
				Send("!1{end}+{home}{bs}")
				While PixelGetColor(567, 55, WinGetHandle("b" & $i)) <> 0x0DDFFF
					Send("/who " & $pl[(($ActiveTab = $AutoZombieWinMulti) ? 3 : 1)], 1)
					Send("{enter}")
					Sleep(10)
				WEnd
				SendKeepActive("")
			EndIf
			Timer(-1)
			_DebugLine('Profile page opened from "b' & $i & '".')
			($ActiveTab = $AutoZombieWinMulti) ? Timer(200000) : Timer(30000)
			#cs
			While PixelGetColor(477, 251, WinGetHandle("b" & $i)) = 0x0DACEE
				_DebugLine('"b' & $i & '": Unable to follow chosen player.')
				ControlClick("b" & $i, "", "", "main", 1, 607 - 2, 280 - 23)
				Sleep(3100)
			WEnd
			#ce
			If PixelGetColor(477, 251, WinGetHandle("b" & $i)) = 0x0DACEE Then
				_DebugLine('"b' & $i & '": Unable to follow chosen player.')
				ControlSend("b" & $i, "", "", "{esc}")
				While PixelGetColor(775, 590, WinGetHandle("b" & $i)) <> 0xFF5B36
					Sleep(10)
				WEnd
				ContinueLoop
			EndIf
			ControlClick("b" & $i, "", "", "main", 1, 450 - 2, 273 - 23)
			Timer(-1)
			_DebugLine('"b' & $i & '": Following chosen player and waiting for password prompt.')
			Timer(30000)
			While Sleep(10)
				If PixelGetColor(492, 282, WinGetHandle("b" & $i)) = 0xFFFFFF Then
					ControlClick("b" & $i, "", "", "main", 2, 492, 282)
					SendKeepActive("b" & $i)
					Send((($ActiveTab = $AutoZombieWinMulti) ? $pass[3] : $pwd), 1)
					Send("{enter}")
					SendKeepActive("")
					_DebugLine('"b' & $i & '": Room password entered.')
					While ($ActiveTab = $AutoZombieWinMulti)
						Sleep(10)
						If PixelGetColor(484, 241, WinGetHandle("b" & $i)) = 0x0450A3 Then
							ExitLoop
						ElseIf PixelGetColor(552, 274, WinGetHandle("b" & $i)) = 0x0CDFFF Then
							ControlSend("b" & $i, "", "", "{esc}")
							ContinueLoop 3
						EndIf
					WEnd
					ExitLoop
				ElseIf PixelGetColor(484, 241, WinGetHandle("b" & $i)) = 0x0450A3 Then
					ExitLoop
				EndIf
			WEnd
			ExitLoop
		Until 0
		Timer(-1)
	Next
	Return _DebugLine("PreAuto2() completed.")
EndFunc

Func PreAuto()
	HotKeySet("^{f7}", "PauseAuto") ; ^{f6} for Ctrl+F6, ! for Alt, + for Shift, # for Windows
	HotKeySet("^{f8}", "StopAuto")
	_DebugLine("PreAuto() started.")
	WinActivate("b1")
	PeriodicDisCheck(True)
	$looptime = TimerInit()
	If $ActiveTab = $AutoZombieWinMulti Then
		$whomode = 2
		$pwd = $pass[3]
	Else
		$pwd = ""
		For $i = 1 To 4
			$pwd &= Chr(Random(97, 122, 1))
		Next
	EndIf
	_DebugLine("Loop time and room password initialized.")
	SplashSet("Mật khẩu phòng: " & $pwd & @CRLF & "Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & _
			@CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
	PreAutoCreateRoom()
	Timer(30000)
	While PixelGetColor(211, 49, WinGetHandle("b1")) <> 0x00c3f4
		Sleep(10)
	WEnd
	Timer(-1)
	_DebugLine("Inside room.")
	SelectMap()
	PreAutoChangeTeams()
	PreAuto2()
	_DebugLine("PreAuto() completed.")
	Return PostLoginAuto()
EndFunc

Func PreAutoCreateRoom()
	_DebugLine("Creating room.")
	Timer(30000)
	Do
		ControlClick("b1", "", "", "main", 2, 284, 59)
		If PixelGetColor(122, 119, WinGetHandle("b1")) = 16777215 Then
			_DebugLine('No event mode dialog.')
			SendKeepActive("b1")
			Send($DefaultRoomName, 1)
			If $ActiveTab = $AutoWho And $whomode = 0 Then
				ControlClick("b1", "", "", "main", 1, 675 - 2, 240 - 23)
				If $whomode = 1 Then ControlClick("b1", "", "", "main", 1, 115, 250)
			Else
				ControlClick("b1", "", "", "main", 1, 225, 250)
			EndIf
			ControlClick("b1", "", "", "main", 2, 407 - 2, 417 - 23)
			ControlClick("b1", "", "", "main", 1, 272 - 2, 446 - 23)
			ControlClick("b1", "", "", "main", 2, 562 - 2, 443 - 23)
			ExitLoop
		ElseIf PixelGetColor(60, 119, WinGetHandle("b1")) = 16777215 Then
			_DebugLine('Plus event mode dialog.')
			SendKeepActive("b1")
			Send($DefaultRoomName, 1)
			If $ActiveTab = $AutoWho And $whomode = 0 Then
				ControlClick("b1", "", "", "main", 1, 675 - 2, 240 - 23)
				If $whomode = 1 Then ControlClick("b1", "", "", "main", 1, 115, 250)
			Else
				ControlClick("b1", "", "", "main", 1, 225, 250)
			EndIf
			ControlClick("b1", "", "", "main", 2, 439, 396)
			ControlClick("b1", "", "", "main", 1, 267, 423)
			ControlClick("b1", "", "", "main", 2, 571 - 2, 445 - 23)
			ExitLoop
		EndIf
	Until Not Sleep(10)
	Send($pwd, 1)
	Send("{enter}")
	SendKeepActive("")
	Timer(-1)
	Return _DebugLine("Creating room completed.")
EndFunc

Func PreAutoChangeTeams()
	If ($ActiveTab = $AutoEXP And $expmode = 0) Or ($ActiveTab = $AutoWho And $whomode <> 2) Then
		_DebugLine("Changing teams.")
		Timer(30000)
		Do
			If $pl[2] <> "" Then ControlClick("b1", "", "", "menu", 1, 589 - 2, 320 - 23)
			ControlClick("b1", "", "", "main", 1, 589 - 2, 320 - 23)
			For $i = 2 To ($ActiveTab = $AutoEXP ? 2 : $windows )
				($InviteMode = 1) ? ControlSend("b1", "", "", "!" & $i & "{enter 3}") : ControlSend("b" & $i, "", "", "!1{enter 2}")
			Next
			Sleep(10)
		Until (($pl[2] <> "") ? _
				((PixelGetColor(608, 287, WinGetHandle("b1")) = 0x24ffff And PixelGetColor(607, 299, WinGetHandle("b1")) = 0x7fff00) Or _
				(PixelGetColor(586, 290, WinGetHandle("b1")) = 0x24ffff And PixelGetColor(586, 302, WinGetHandle("b1")) = 0x7fff00)) : _
				(PixelGetColor(608, 287, WinGetHandle("b1")) = 0x24ffff Or PixelGetColor(586, 290, WinGetHandle("b1")) = 0x24ffff))
		Timer(-1)
		Return _DebugLine("Teams changed.")
	EndIf
EndFunc

Func CheckDis()
	Local $dis = 0
	If WinExists("login fail", "Can't Connect") Or WinExists("Kết nối thất bại.") Or WinExists("CrashDlg") Or WinExists("Error", "HS_") Then
		_DebugLine('"CrashDlg" or "login fail" or "Error" ("HS_*") window exists.')
		While WinClose("login fail")
			Sleep(100)
		WEnd
		While WinClose("Kết nối thất bại.")
			Sleep(100)
		WEnd
		While WinClose("Error", "HS_")
			Sleep(100)
		WEnd
		While WinExists("CrashDlg")
			WinKill("CrashDlg")
			Sleep(100)
		WEnd
		$dis = 1
	ElseIf $ActiveTab = $AutoNeedle Then
		If Not WinExists("[TITLE:Boom; CLASS:Crazy Arcade]") Then $dis = 1
	Else
		For $i = 1 To $windows
			If Not (WinExists("b" & $i)) Then $dis = 1
		Next
	EndIf
	Switch $dis
		Case 0
			Return _DebugLine("CheckDis() result: 0 (OK).")
		Case Else
			_DebugLine('CheckDis() result: 1 ("login fail" or missing windows).')
			Return KillAndRefresh()
	EndSwitch
EndFunc

Func KillAndRefresh()
	KillTimers()
	_DebugLine("KillAndRefresh() started.")
	SplashSet("Đang đăng nhập lại" & @CRLF & "Ctrl+F7: Tạm dừng - Ctrl+F9: Thoát" & @CRLF & _
			"Ctrl+F12: Dừng && trở về giao diện chọn auto")
	SendKeepActive("")
	HotKeySet("^{f6}")
	HotKeySet("^{f8}")
	_DebugLine('Killing all windows...')
	$time = KillAll()
	_DebugLine('All windows killed for ' & Round($time / 1000, 3) & 's. KillAndRefresh() completed.')
	HotKeySet("^{f9}")
	OnAutoItExitUnRegister("PowerResetState")
	WinFade($splashwindow, "", 200, 0, -25)
	GUIDelete($splashwindow)
	AutoItWinSetTitle($autoname & " – Resetting...")
	Run(FullShortcutCommand())
	Exit 1
EndFunc

Func LadderPushStart()
	HotKeySet("{f6}")
	GUICtrlSetData($LadderPushStartButton, "Đang thực hiện...")
	For $i = $LadderPushStartWindows To 1 Step -1
		ControlClick(GUICtrlRead($WindowNameInput[$i]), "", "", "main", 2, 604, 520)
	Next
	GUICtrlSetData($LadderPushStartButton, "Bấm bắt đầu trên các cửa sổ (F6)")
	Return HotKeySet("{f6}", "LadderPushStart")
EndFunc

Func NPCBug()
	HotKeySet("{f6}")
	GUICtrlSetData($NPCBugButton, "Đang thực hiện...")
	For $i = 3 To 0 Step (GUICtrlRead($KellyNPCCheck) = 1) ? -1 : 1
		ControlClick($HostWnd, "", "", "main", 1, 73 + (106 * $i), 365) ;opponent selection
		Sleep(150)
		ControlClick($HostWnd, "", "", "main", 3, ($i = 3) ? 177 : (73 + (106 * $i)), 470) ;Kelly NPC
		Sleep(150)
	Next
	ControlClick($HostWnd, "", "", "main", 1, 635, 582) ;my items
	ControlClick($HostWnd, "", "", "main", 1, 543, 330) ;select player 2 (my items)
	ControlClick($HostWnd, "", "", "main", 1, 604, 518) ;start button
	ControlClick($HostWnd, "", "", "main", 1, 73, 365) ;opponent selection
	ControlClick($HostWnd, "", "", "main", 10, 280, 512) ;Leo NPC
	GUICtrlSetData($NPCBugButton, "Thực hiện bug (F6)")
	Return HotKeySet("{f6}", "NPCBug")
EndFunc

Func PrepareForAuto()
	OnExit()
	If $DebugMode And $DebugModeFlag And FileGetSize("AutoBoom-TDStoneheart-Debug.log") > 10485760 Then
		If MsgBox(48 + 4, "Dữ liệu báo cáo lỗi quá lớn", _
				"Dữ liệu trong tệp báo cáo lỗi vượt quá 10 MB." & @CRLF & _
				"Bạn có muốn xoá tệp báo cáo lỗi hiện tại để giải phóng bộ nhớ không?" & @CRLF & _
				"Đừng xoá nếu bạn đang thu thập dữ liệu để dò lỗi trong auto.") = 6 Then _
				FileDelete("AutoBoom-TDStoneheart-Debug.log")
	EndIf
	If StringInStr($CmdLineRaw, "/shortcut", 2) And ($login = 4 Or $ActiveTab = 1) Then
		Switch $ActiveTab
			Case $AutoWho To $AutoZombieWinMulti
				$ShortcutGUI = GUICreate($autoname, 320, $GUIHeight)
				WinSetTrans($ShortcutGUI, "", 225)
				RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "DejaVu Sans (TrueType)")
				@error ? GUIFont() : GUISetFont(9, 0, 0, "DejaVu Sans")
				GUICtrlCreateLabel("Lối tắt chạy auto bằng dòng lệnh:", 16, 12, 220, 32)
				$ProceedButton = GUICtrlCreateButton("OK", 240, 12, 64, 32, $BS_DEFPUSHBUTTON)
				GUICtrlCreateEdit(FullShortcutCommand(), 16, 50, 288, $GUIHeight - 60, 0x00200804)
				WinSetTrans($ShortcutGUI, "", 0)
				GUISetState(@SW_SHOW, $ShortcutGUI)
				WinFade($ShortcutGUI, "", 0, 225, 25)
				While 1
					Switch GUIGetMsg()
						Case $ProceedButton, $GUI_EVENT_CLOSE
							WinFade($ShortcutGUI, "", 225, 0, -25)
							GUIDelete($ShortcutGUI)
							ExitLoop
					EndSwitch
				WEnd
		EndSwitch
	EndIf
	If $DebugMode Then _DebugSetup($autoname & " (Debug/Notepad)", True, _
			$DebugModeFlag ? 4 : 5, "AutoBoom-TDStoneheart-Debug.log", True)
	If $ActiveTab = $MiniAuto Then ;$TabSheetMiniAuto
		Switch $MoreMode
			Case $AutoMoreFishing, $AutoMoreMarket, $AutoMoreMarketMulti
				SplashSet("F5: Chạy auto" & @CRLF & "F1: Dừng auto" & _
						@CRLF & "Ctrl+F8: Trở về menu thiết đặt auto" & _
						@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
						@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
				HotKeySet("{f5}", "RunAuto")
				HotKeySet("^{f8}", "AutoMarketGUI")
			Case $AutoMoreDice, $AutoMoreLose
				SplashSet("F5: Chạy auto" & @CRLF & "Ctrl+F7: Tạm dừng" & _
						@CRLF & "F1: Dừng auto" & _
						@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
						@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
				HotKeySet("{f5}", "RunAuto")
			Case $AutoMoreQuestItemMulti
				SplashSet("Ctrl+F5: Chạy auto" & @CRLF & "F1: Dừng auto" & _
						@CRLF & "Ctrl+F8: Trở về menu thiết đặt auto" & _
						@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
						@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
				HotKeySet("^{f5}", "RunAuto")
				HotKeySet("^{f8}", "AutoMarketGUI")
			Case Else
				SplashSet("Ctrl+F5: Chạy auto" & (($MoreMode = $AutoMoreQuestItem) ? @CRLF & "Ctrl+F7: Tạm dừng" : "") & _
						@CRLF & "Ctrl+F8: Dừng auto" & _
						@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
						@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
				HotKeySet("^{f5}", "RunAuto")
		EndSwitch
	ElseIf $login <> 1 Or $ActiveTab = $AutoNeedle Then ;not logged in or AutoNeedle
		SplashSet("Ctrl+F5: Bắt đầu đăng nhập && chạy auto" & _
				@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
				@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
		HotKeySet("^{f5}", "RunAuto")
	Else ;logged in
		SplashSet("Ctrl+F6: Bắt đầu chạy auto" & _
				@CRLF & "Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
				"Ctrl+F12: Dừng && trở về giao diện chọn auto")
		HotKeySet("^{f6}", "PostLoginAuto")
	EndIf
	HotKeySet("^{f9}", "Out")
	HotKeySet("^{f12}", "BackToGUI")
	HotKeySet("+{pause}", "DisableInput")
	_DebugLine("Initial hot keys set. Waiting for user...")
	While Sleep(100) ;Sleep() returns 1
	WEnd
EndFunc

Func PauseAuto()
	HotKeySet("^{f5}")
	HotKeySet("^{f6}")
	HotKeySet("^{f7}")
	If $timer >= 0 Then
		$timer = $timer - Round(TimerDiff($wait))
		AdlibUnRegister("KillAndRefresh")
	EndIf
	AdlibUnRegister("CheckDis")
	$LastActiveWindow = WinGetHandle("[ACTIVE]")
	HotKeys(False)
	GUISwitch($splashwindow)
	Local $lastsplashtext = GUICtrlRead($splashstatic)
	_DebugLine("Automation paused!")
	SplashSet("Auto đang tạm dừng" & @CRLF & "Nhấp vào cửa sổ này để tiếp tục chạy auto" & @CRLF & _
			"Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
	GUICtrlSetTip($splashstatic, "Nhấp vào để tiếp tục chạy auto.")
	Do
	Until GUIGetMsg() = $splashstatic
	GUICtrlSetTip($splashstatic, "")
	SplashSet($lastsplashtext)
	HotKeySet("^{f7}", "PauseAuto")
	HotKeys()
	MouseAway()
	WinActivate($LastActiveWindow)
	_DebugLine("Automation unpaused!")
	If $PeriodicCheck Then PeriodicDisCheck(True)
	If $timer >= 0 Then Timer($timer)
EndFunc

Func StopAuto()
	Timer(-1)
	KillTimers()
	HotKeySet("^{f7}")
	HotKeySet("^{f8}")
	HotKeys(False)
	AdlibUnRegister("PressStartOnDemand")
	Switch $ActiveTab
		Case $AutoNeedle
			HotKeySet("^{f5}", "AutoNeedle")
		Case $MiniAuto
			Switch $MoreMode
				Case $AutoMoreFishing, $AutoMoreMarket, $AutoMoreMarketMulti
					HotKeySet("{f1}")
					HotKeySet("{f5}", "RunAuto")
					HotKeySet("^{f8}", "AutoMarketGUI")
				Case $AutoMoreDice, $AutoMoreLose
					HotKeySet("{f1}")
					HotKeySet("{f5}", "RunAuto")
				Case $AutoMoreQuestItemMulti
					HotKeySet("{f1}")
					HotKeySet("^{f5}", "RunAuto")
					HotKeySet("^{f8}", "AutoMarketGUI")
				Case Else
					HotKeySet("^{f5}", "RunAuto")
			EndSwitch
		Case Else
			HotKeySet("^{f5}")
			HotKeySet("^{f6}", "PostLoginAuto")
	EndSwitch
	_DebugLine("Hot keys set. Automation stopped.")
	Local $AutoMsg
	Switch $ActiveTab
		Case $AutoNeedle
			$AutoMsg = "Ctrl+F5: Chạy lại auto" & @CRLF & "(đăng nhập lại ở lần hiện tại)"
		Case $AutoLadder
			$AutoMsg = "Ctrl+F6: Chạy lại auto" & @CRLF & "(đăng nhập ở phòng chờ " & _
					($FirstSwap ? $ChannelName : $ChannelName2) & ")"
		Case $MiniAuto
			Switch $MoreMode
				Case $AutoMoreFishing, $AutoMoreMarket, $AutoMoreMarketMulti
					$AutoMsg = "F5: Chạy lại auto" & @CRLF & "Ctrl+F8: Trở về menu thiết đặt auto"
				Case $AutoMoreQuestItemMulti
					$AutoMsg = "Ctrl+F5: Chạy lại auto" & @CRLF & "Ctrl+F8: Trở về menu thiết đặt auto"
				Case $AutoMoreDice, $AutoMoreLose
					$AutoMsg = "F5: Chạy lại auto (từ phòng chờ)"
				Case Else
					$AutoMsg = "Ctrl+F5: Chạy lại auto"
			EndSwitch
		Case Else
			$AutoMsg = "Ctrl+F6: Chạy lại auto" & @CRLF & "(đăng nhập ở cùng một phòng theo yêu cầu)"
	EndSwitch
	SplashSet("Đã dừng auto" & @CRLF & $AutoMsg & @CRLF & _
			"Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
	While Sleep(100)
	WEnd
EndFunc

Func RunAuto()
	_DebugLine("RunAuto() invoked.")
	Switch $ActiveTab
		Case $AutoNeedle
			Return AutoNeedle()
		Case $MiniAuto
			Switch $MoreMode
				Case $AutoMorePushStart
					Return AutoPushStart()
				Case $AutoMoreQuestItem
					Return AutoQuestItem()
				Case $AutoMoreDice
					Return AutoDicing()
				Case $AutoMoreFishing, $AutoMoreMarket, $AutoMoreMarketMulti, $AutoMoreQuestItemMulti
					Return AutoMarket()
				Case $AutoMoreLose
					Return AutoLose()
			EndSwitch
		Case Else
			Return LoginAuto()
	EndSwitch
EndFunc

Func PostLoginAuto()
	_DebugLine("PostLoginAuto() invoked.")
	Switch $ActiveTab
		Case $AutoWho
			Return AutoWho()
		Case $AutoNeedle
			Return AutoNeedle()
		Case $AutoEXP
			Return AutoExp()
		Case $AutoLadder
			Return AutoLadder()
		Case $AutoZombieWinMulti
			Return AutoZombieWinMulti()
	EndSwitch
EndFunc

Func BackToGUI()
	_DebugLine("BackToGUI() invoked.")
	Timer(-1)
	KillTimers()
	AdlibUnRegister("PressStartOnDemand")
	SendKeepActive("")
	$CheckForUpdates = False
	$w = 1
	WinFade($splashwindow, "", 200, 0, -25)
	GUIDelete($splashwindow)
	Return AutoMainGUI()
EndFunc

Func LoginAuto()
	HotKeySet("^{f5}")
	HotKeySet("^{f7}", "PauseAuto")
	Timer(-1)
	_DebugLine("LoginAuto() started.")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "AutoReady", "REG_SZ", "1")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "FullScreen", "REG_SZ", "0")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "ShowLobbySquareChat", "REG_SZ", "1")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "ShowLobbySquareLeftSideUI", "REG_SZ", "1")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "ShowLobbySquareMiniMapUI", "REG_SZ", "1")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\MPlay\Crazy Arcade", "ShowLobbySquareRoomUI", "REG_SZ", "1")
	For $i = 1 To $windows
		SplashSet("Đang đăng nhập (" & $i & "/" & $windows & ")" & @CRLF & _
				"Ctrl+F7: Tạm dừng - Ctrl+F9: Thoát" & @CRLF & _
				"Ctrl+F12: Dừng && trở về giao diện chọn auto")
		If Not WinExists("[TITLE:b" & $i & "; CLASS:Crazy Arcade]") Then
			NewWindow("b" & $i)
			PostLogin("b" & $i, $pl[2 * $i - 1], $pass[2 * $i - 1], $pl[2 * $i], $pass[2 * $i])
		EndIf
		DismissAds("b" & $i, $i = 1 Or ($ActiveTab = $AutoLadder And $i = 2))
		If $InviteMode = 1 Then
			If ($ActiveTab = $AutoWho And $whomode <> 2 And $i = 1) Or _
					($ActiveTab = $AutoLadder And $i < 3 And $windows > 2 And 0) Then
				Timer(30000)
				WinActivate("b" & $i)
				Do
					ControlSend("b" & $i, "", "", "{F9}")
					Sleep(10)
				Until PixelGetColor(363, 132, WinGetHandle("b" & $i)) = 0xFFFFFF
				_DebugLine('Creating Alt+number commands for "b' & $i & '".')
				SendKeepActive("b" & $i)
				Sleep(10)
				If $ActiveTab = $AutoLadder Then
					Send("/in " & $pl[2 * $i + 3], 1)
				Else
					For $c = 2 To $windows
						Send("{tab}")
						Send("/in " & $pl[2 * $c - 1], 1)
					Next
				EndIf
				Send("{enter}")
				SendKeepActive("")
				Timer(-1)
			EndIf
		ElseIf (($ActiveTab = $AutoWho And $whomode = 0 And $i > 1) Or ($ActiveTab = $AutoLadder And $i > 2)) Then
			Timer(30000)
			WinActivate("b" & $i)
			Do
				ControlSend("b" & $i, "", "", "{F9}")
				Sleep(10)
			Until PixelGetColor(363, 132, WinGetHandle("b" & $i)) = 0xFFFFFF
			_DebugLine('Creating Alt+1 command for "b' & $i & '".')
			SendKeepActive("b" & $i)
			Sleep(10)
			Send("/who " & $pl[(($ActiveTab = $AutoLadder And $i = 4) ? 3 : 1)], 1)
			Send("{enter}")
			SendKeepActive("")
			Timer(-1)
		EndIf
		If ($ActiveTab = $AutoEXP And $expmode = 0) Or ($ActiveTab = $AutoWho And $whomode = 2) _
			Or ($ActiveTab = $AutoWho And $whomode = 1 And $i = 1) Then ;remove pets
			WinActivate("b" & $i)
			Timer(30000)
			If 0 Then
				_DebugLine('Hiding room pane for "b' & $i & '".')
				While PixelGetColor(302, 26, WinGetHandle("b" & $i)) = 0xFBA00E
					ControlSend("b" & $i, "", "", "{esc}")
					Sleep(500)
				WEnd
			EndIf
			_DebugLine('Opening "My Items" page for "b' & $i & '".')
			While 1
				ControlClick("b" & $i, "", "", "main", 1, 663, 587)
				Sleep(10)
				If $pl[2 * $i] <> "" Then
					If PixelGetColor(510, 31, WinGetHandle("b" & $i)) = 0x0DDFFF Or _
							PixelGetColor(493, 214, WinGetHandle("b" & $i)) = 0x0CDFFF Then ExitLoop
				Else
					If PixelGetColor(510, 31, WinGetHandle("b" & $i)) = 0x0DDFFF Or _
							PixelGetColor(512, 198, WinGetHandle("b" & $i)) = 0x0CDFFF Then ExitLoop
				EndIf
			WEnd
			If $pl[2 * $i] <> "" Then
				ControlClick("b" & $i, "", "", "main", 1, 540 - 2, 329 - 23)
				While Not (PixelGetColor(510, 31, WinGetHandle("b" & $i)) = 0x0DDFFF Or PixelGetColor(512, 198, WinGetHandle("b" & $i)) = 0x0CDFFF)
					Sleep(10)
				WEnd
			EndIf
			For $c = 0 To Bit($pl[2 * $i] <> "")
				ControlSend("b" & $i, "", "", "{space}")
				Do
					ControlClick("b" & $i, "", "", "main", 2, 100, 200)
					Sleep(10)
				Until PixelChecksum(74, 184, 118, 212, 2, WinGetHandle("b" & $i)) = 1419992376
				ControlSend("b" & $i, "", "", "{esc}")
				If $pl[2 * $i] <> "" And $c = 0 Then
					Do
						ControlClick("b" & $i, "", "", "main", 1, 663, 587)
						Sleep(10)
					Until PixelGetColor(493, 214, WinGetHandle("b" & $i)) = 0x0CDFFF
					ControlClick("b" & $i, "", "", "main", 1, 540 - 2, 355 - 23)
					While Not (PixelGetColor(510, 31, WinGetHandle("b" & $i)) = 0x0DDFFF Or PixelGetColor(512, 198, WinGetHandle("b" & $i)) = 0x0CDFFF)
						Sleep(10)
					WEnd
				EndIf
			Next
			If 0 Then
				ControlClick("b" & $i, "", "", "main", 1, 735, 10)
				_DebugLine('Showing room pane for "b' & $i & '".')
				While PixelGetColor(302, 26, WinGetHandle("b" & $i)) <> 0xFBA00E
					Sleep(10)
				WEnd
			EndIf
			Timer(-1)
		EndIf
	Next
	$list = WinList("[TITLE:Boom; CLASS:Crazy Arcade]")
	If IsArray($list) Then
		For $i = 1 To $list[0][0]
			WinClose($list[$i][1])
			WinKill($list[$i][1])
		Next
	EndIf
	_DebugLine("LoginAuto() completed.")
	PeriodicDisCheck(True)
	Switch $ActiveTab
		Case $AutoWho, $AutoEXP
			PreAuto()
		Case $AutoZombieWinMulti
			If $HostMode = 1 Then
				PreAuto()
			Else
				PreAuto2()
				AutoZombieWinMulti()
			EndIf
		Case $AutoLadder
			AutoLadder()
	EndSwitch
EndFunc

Func ReLogin()
	Timer(-1)
	KillTimers()
	MouseAway()
	HotKeySet("^{f6}")
	HotKeySet("^{f8}")
	_DebugLine("ReLogin() invoked.")
	SplashSet("Đang đăng nhập lại" & @CRLF & "Ctrl+F7: Tạm dừng - Ctrl+F9: Thoát" & @CRLF & _
			"Ctrl+F12: Dừng && trở về giao diện chọn auto")
	For $i = 1 To $windows
		_DebugLine('Taking "b' & $i & '" to login screen.')
		WinActivate("b" & $i)
		ControlSend("b" & $i, "", "", "{up 25}{enter}")
		Timer(30000)
		While PixelGetColor(384, 580, WinGetHandle("b" & $i)) <> 0x25B1FA
			ControlSend("b" & $i, "", "", "{ENTER}")
			ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
			Sleep(10)
		WEnd
		Timer(-1)
		PostLogin("b" & $i, $pl[2 * $i - 1], $pass[2 * $i - 1], $pl[2 * $i], $pass[2 * $i])
	Next
	_DebugLine("ReLogin() completed. Warping to PreAuto()...")
	Return PreAuto()
EndFunc

Func AutoMarketGUI()
	HotKeySet("{f5}")
	HotKeySet("{f6}")
	HotKeySet("^{f8}")
	HotKeySet("^{f9}")
	HotKeySet("^{f12}")
	HotKeySet("+{pause}")
	AdlibUnRegister("PressStartOnDemand")
	WinFade($splashwindow, "", 200, 0, -25)
	GUIDelete($splashwindow)
	Switch $MoreMode
		Case $AutoMoreMarket
			$MarketConfigGUI = GUICreate("Thiết đặt auto chợ trời", 320, 210)
			GUIFont()
			GUICtrlCreateGroup("Tiêu chí", 16, 8, 288, 45)
			$TimeCriterion = GUICtrlCreateRadio("Mới nhất", 24, 25, 90, 25)
			GUICtrlSetState(-1, $GUI_CHECKED)
			$LowCostCriterion = GUICtrlCreateRadio("Giá thấp", 115, 25, 90, 25)
			$HighCostCriterion = GUICtrlCreateRadio("Giá cao", 206, 25, 90, 25)
			GUICtrlSetState($MarketCriterion = 1 ? $LowCostCriterion : ($MarketCriterion = 2 ? $HighCostCriterion : $TimeCriterion), $GUI_CHECKED)
			GUICtrlCreateGroup("", -99, -99, 1, 1)
			GUICtrlCreateGroup("Thể loại", 16, 58, 145, 45)
			$HotItemsCheck = GUICtrlCreateCheckbox("Hot", 24, 75, 50, 25)
			Switch $MarketHotItems
				Case 1, 4
					GUICtrlSetState(-1, $MarketHotItems)
				Case Else
					GUICtrlSetState(-1, $GUI_CHECKED)
			EndSwitch
			$PurpleTextCheck = GUICtrlCreateCheckbox('"Chữ tím"', 75, 75, 80, 25)
			Switch $MarketPurpleText
				Case 1, 4
					GUICtrlSetState(-1, $MarketPurpleText)
				Case Else
					GUICtrlSetState(-1, $GUI_CHECKED)
			EndSwitch
			GUICtrlCreateGroup("", -99, -99, 1, 1)
			$AnyItemsCheck = GUICtrlCreateCheckbox('Hot hoặc "chữ tím"', 172, 75, 132, 25)
			Switch $MarketAnyItems
				Case 1, 4
					GUICtrlSetState(-1, $MarketAnyItems)
			EndSwitch
			GUICtrlSetState($HotItemsCheck, (GUICtrlRead($AnyItemsCheck) = 1) ? $GUI_DISABLE : $GUI_ENABLE)
			GUICtrlSetState($PurpleTextCheck, (GUICtrlRead($AnyItemsCheck) = 1) ? $GUI_DISABLE : $GUI_ENABLE)
			$PurchaseAlertCheck = GUICtrlCreateCheckbox('Báo đã mua vật phẩm', 16, 105, 175, 25)
			Switch $MarketPurchaseAlert
				Case 1, 4
					GUICtrlSetState(-1, $MarketPurchaseAlert)
				Case Else
					GUICtrlSetState(-1, $GUI_CHECKED)
			EndSwitch
			$AutoMarketButton = GUICtrlCreateButton("Chạy auto", 191, 105, 113, 25, $BS_DEFPUSHBUTTON)
			GUICtrlCreateLabel("Hướng dẫn: Đưa cửa sổ Boom (với tên đã nhập) vào chợ trời, " & _
					"chọn thể loại vật phẩm (y phục, nhãn,...) mà bạn quan tâm rồi chạy auto." & _
					@CRLF & "Cửa sổ dùng auto: " & ((WinExists($HostWnd) And $HostWnd) ? WinGetTitle($HostWnd) : _
					"Cần kích hoạt khi chạy auto"), 16, 135, 288, 70)
			WinSetTrans($MarketConfigGUI, "", 0)
			GUISetState(@SW_SHOW, $MarketConfigGUI)
			WinFade($MarketConfigGUI, "", 0, 225, 25)
			Do
				Switch GUIGetMsg()
					Case -3
						WinFade($MarketConfigGUI, "", 225, 0, -25)
						GUIDelete($MarketConfigGUI)
						Return AutoMainGUI()
					Case $AnyItemsCheck
						GUICtrlSetState($HotItemsCheck, (GUICtrlRead($AnyItemsCheck) = 1) ? $GUI_DISABLE : $GUI_ENABLE)
						GUICtrlSetState($PurpleTextCheck, (GUICtrlRead($AnyItemsCheck) = 1) ? $GUI_DISABLE : $GUI_ENABLE)
					Case $AutoMarketButton
						Select
							Case GUICtrlRead($LowCostCriterion) = $GUI_CHECKED
								$MarketCriterion = 1
							Case GUICtrlRead($HighCostCriterion) = $GUI_CHECKED
								$MarketCriterion = 2
							Case Else
								$MarketCriterion = 0
						EndSelect
						$MarketAnyItems = GUICtrlRead($AnyItemsCheck)
						If $MarketAnyItems = 4 Then
							$MarketHotItems = GUICtrlRead($HotItemsCheck)
							$MarketPurpleText = GUICtrlRead($PurpleTextCheck)
						EndIf
						$MarketPurchaseAlert = GUICtrlRead($PurchaseAlertCheck)
						WinFade($MarketConfigGUI, "", 225, 0, -25)
						GUIDelete($MarketConfigGUI)
						Return PrepareForAuto()
				EndSwitch
			Until 0
		Case $AutoMoreFishing
			$PressDelay = 200
			$FishingConfigGUI = GUICreate("Thiết đặt auto câu cá", 320, 210)
			GUIFont()
			GUICtrlCreateGroup("Hướng dẫn", 16, 8, 288, 145)
			GUICtrlCreateLabel('* Chuẩn bị auto ở ven bờ (nơi có thể nhấn phím cách để câu cá) tại một quảng trường bất kì.' & @CRLF & _
					'* Chọn mồi câu sẽ sử dụng rồi huỷ bỏ.' & @CRLF & _
					'* Chú ý rằng xác suất câu cá thành công không phải là 100%. ' & _
					'Thay đổi chu kì nhấn phím có thể không làm thay đổi khả năng câu cá thành công, ' & _
					'do đó đừng thay đổi trừ khi cần thiết.' & @CRLF & _
					"* Cửa sổ dùng auto: " & ((WinExists($HostWnd) And $HostWnd) ? WinGetTitle($HostWnd) : _
					"Cần kích hoạt khi chạy auto"), 24, 28, 272, 120)
			GUICtrlCreateGroup("", -99, -99, 1, 1)
			GUICtrlCreateGroup("Chu kì nhấn phím", 16, 155, 130, 45)
			$PressCycle = GUICtrlCreateInput((StringIsDigit($PressDelay) ? $PressDelay : 200), 24, 175, 40, 20, 0x2002)
			GUICtrlSetLimit($PressCycle, 4)
			GUICtrlCreateLabel("/1000 giây", 65, 175, 60, 20)
			GUICtrlCreateGroup("", -99, -99, 1, 1)
			$AutoFishingButton = GUICtrlCreateButton("Chạy auto", 191, 165, 113, 25, $BS_DEFPUSHBUTTON)
			WinSetTrans($FishingConfigGUI, "", 0)
			GUISetState(@SW_SHOW, $FishingConfigGUI)
			WinFade($FishingConfigGUI, "", 0, 225, 25)
			Do
				Switch GUIGetMsg()
					Case -3
						WinFade($FishingConfigGUI, "", 225, 0, -25)
						GUIDelete($FishingConfigGUI)
						Return AutoMainGUI()
					Case $AutoFishingButton
						$PressDelay = (StringIsDigit(GUICtrlRead($PressCycle)) ? Number(GUICtrlRead($PressCycle)) : 200)
						WinFade($FishingConfigGUI, "", 225, 0, -25)
						GUIDelete($FishingConfigGUI)
						Return PrepareForAuto()
				EndSwitch
			Until 0
		Case $AutoMoreLadderPushStart, $AutoMoreMarketMulti, $AutoMoreQuestItemMulti
			$PressDelay = 1000
			Local $title
			Switch $MoreMode
				Case $AutoMoreLadderPushStart
					$title = "Auto hỗ trợ siêu cấp"
				Case $AutoMoreMarketMulti
					$title = "Auto chợ trời (nhiều cửa sổ)"
				Case $AutoMoreQuestItemMulti
					$title = "Auto vật phẩm nhiệm vụ (nhiều cửa sổ)"
			EndSwitch
			$LadderPushStartGUI = GUICreate($title, 320, (30 * $LadderPushStartWindows) + ($MoreMode = $AutoMoreMarketMulti ? 140 : 75))
			GUIFont()
			GUICtrlCreateGroup($MoreMode <> $AutoMoreLadderPushStart ? "Nhập tên các cửa sổ để chạy auto" : "Nhập tên các cửa sổ để bấm bắt đầu", _
					16, 8, 288, (30 * $LadderPushStartWindows) + 25)
			For $i = 1 To $LadderPushStartWindows
				$WindowNameInput[$i] = GUICtrlCreateInput("[TITLE:b" & $i & "; CLASS:Crazy Arcade]", 24, 30 * $i, 272, 25)
			Next
			GUICtrlCreateGroup("", -99, -99, 1, 1)
			If $MoreMode <> $AutoMoreMarketMulti Then
				$LadderPushStartButton = GUICtrlCreateButton($MoreMode = $AutoMoreLadderPushStart ? _
						"Bấm bắt đầu trên các cửa sổ (F6)" : "Chạy auto", _
						16, (30 * $LadderPushStartWindows) + 40, 288, 25, $BS_DEFPUSHBUTTON)
			Else
				$LadderPushStartButton = GUICtrlCreateButton("Chạy auto", _
						16, (30 * $LadderPushStartWindows) + 40, 180, 25, $BS_DEFPUSHBUTTON)
				$SearchSpecificMode = GUICtrlCreateCheckbox("Tìm kiếm", 206, (30 * $LadderPushStartWindows) + 40, 100, 25)
				$PressCycle = GUICtrlCreateInput((StringIsDigit($PressDelay) ? $PressDelay : 1000), _
						16, (30 * $LadderPushStartWindows) + 75, 43, 20, 0x2002)
				GUICtrlSetLimit($PressCycle, 4)
				GUICtrlCreateLabel("/1000 giây thời gian chờ hiện vật phẩm", 60, (30 * $LadderPushStartWindows) + 75, 246, 20)
				GUICtrlCreateLabel('Chạy auto từ mục "Toàn bộ" ở chợ trời nếu không đánh dấu "Tìm kiếm."', _
						16, (30 * $LadderPushStartWindows) + 95, 288, 40)
			EndIf
			WinSetTrans($LadderPushStartGUI, "", 0)
			GUISetState(@SW_SHOW, $LadderPushStartGUI)
			WinFade($LadderPushStartGUI, "", 0, 225, 25)
			If $MoreMode = $AutoMoreLadderPushStart Then HotKeySet("{f6}", "LadderPushStart")
			While 1
				Switch GUIGetMsg()
					Case -3
						HotKeySet("{f6}")
						WinFade($LadderPushStartGUI, "", 225, 0, -25)
						GUIDelete($LadderPushStartGUI)
						Return AutoMainGUI()
					Case $LadderPushStartButton
						If $MoreMode <> $AutoMoreLadderPushStart Then
							For $i = 1 To $LadderPushStartWindows
								$WindowNameInput[$i] = GUICtrlRead($WindowNameInput[$i])
							Next
							If $MoreMode = $AutoMoreMarketMulti Then
								$SearchSpecific = GUICtrlRead($SearchSpecificMode)
								$PressDelay = (StringIsDigit(GUICtrlRead($PressCycle)) ? Number(GUICtrlRead($PressCycle)) : 1000)
							EndIf
							WinFade($LadderPushStartGUI, "", 225, 0, -25)
							GUIDelete($LadderPushStartGUI)
							Return PrepareForAuto()
						Else
							LadderPushStart()
						EndIf
				EndSwitch
			WEnd
	EndSwitch
EndFunc

Func PressStartOnDemand()
	For $i = 1 To $LadderPushStartWindows
		ControlClick($WindowNameInput[$i], "", "", "main", 2, 567, 520)
	Next
	Sleep(100)
	For $i = 1 To $LadderPushStartWindows
		ControlClick($WindowNameInput[$i], "", "", "main", 2, 409, 387)
	Next
EndFunc

Func AutoMarket()
	_DebugReportVar("Mode", $ActiveTab)
	_DebugReportVar("MoreMode", $MoreMode)
	HotKeySet("{f5}")
	HotKeySet("{f1}", "StopAuto")
	SplashSet("Auto đang chạy" & _
			@CRLF & "F1: Dừng auto" & _
			@CRLF & "Ctrl+F8: Trở về menu thiết đặt auto" & _
			@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
			@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
	Switch $MoreMode
		Case $AutoMoreFishing
			Do
				ControlSend($HostWnd, "", "", "{space}")
			Until Not Sleep($PressDelay)
		Case $AutoMoreQuestItemMulti
			PressStartOnDemand()
			AdlibRegister("PressStartOnDemand", 5000)
			Do
				SendKeepActive($WindowNameInput[1])
				Send("{left down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{left down}")
				Next
				Sleep(2750)
				Send("{left up}")
				Send("{up down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{up down}")
				Next
				Sleep(1250)
				Send("{up up}")
				Send("{left down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{left down}")
				Next
				Sleep(500)
				Send("{left up}")
				Send("{up down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{up down}")
				Next
				Sleep(1250)
				Send("{up up}")
				Send("{right down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{right down}")
				Next
				Sleep(1250)
				Send("{right up}")
				Send("{up down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{up down}")
				Next
				Sleep(1250)
				Send("{up up}")
				Sleep(500)
				Send("{down down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{down down}")
				Next
				Sleep(1250)
				Send("{down up}")
				Send("{left down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{left down}")
				Next
				Sleep(1250)
				Send("{left up}")
				Send("{down down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{down down}")
				Next
				Sleep(1250)
				Send("{down up}")
				Send("{right down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{right down}")
				Next
				Sleep(500)
				Send("{right up}")
				Send("{down down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{down down}")
				Next
				Sleep(1250)
				Send("{down up}")
				Send("{right down}")
				For $i = 1 To $LadderPushStartWindows
					ControlSend($WindowNameInput[$i], "", "", "{right down}")
				Next
				Sleep(2750)
				Send("{right up}")
			Until Not Sleep(500)
		Case $AutoMoreMarketMulti
			Do
				$timinghandle = TimerInit()
				For $i = 1 To $LadderPushStartWindows
					ControlClick($WindowNameInput[$i], "", "", "main", 1, $SearchSpecific = 1 ? 51 : 116, 93)
					ControlClick($WindowNameInput[$i], "", "", "main", 1, $SearchSpecific = 1 ? 116 : 51, 93)
				Next
				While TimerDiff($timinghandle) < $PressDelay
					Sleep(10)
				WEnd
				For $i = 1 To $LadderPushStartWindows
					ControlClick($WindowNameInput[$i], "", "", "main", 1, 460, 168)
				Next
				$timinghandle = TimerInit()
				For $i = 1 To $LadderPushStartWindows
					ControlClick($WindowNameInput[$i], "", "", "main", 1, 373, 437)
				Next
				While TimerDiff($timinghandle) < $PressDelay / 2
					Sleep(10)
				WEnd
				For $i = 1 To $LadderPushStartWindows
					ControlClick($WindowNameInput[$i], "", "", "main", 1, 404, 409)
				Next
			Until 0
		Case $AutoMoreMarket
			_DebugReportVar("Market criterion", $MarketCriterion)
			While MouseAway()
				WinActivate($HostWnd)
				$currentlucci = PixelChecksum(620, 462, 755, 481, 2, WinGetHandle($HostWnd))
				_DebugReportVar("Current lucci color checksum", $currentlucci)
				Do
					$category = PixelSearch(20, 84, 406, 83, 0x0057B0, 0, 1, WinGetHandle($HostWnd))
					If @error Then _
							Return (MsgBox(48 + 4, "Auto không thể chạy", "Bạn đang không ở chợ trời." & @CRLF & _
							"Bạn có muốn trở về menu thiết đặt auto không?" & @CRLF & _
							"Nếu không, auto sẽ dừng lại.") = 6) ? AutoMarketGUI() : StopAuto()
					_DebugReportVar("Selected category X", $category[0])
					ControlClick($HostWnd, "", "", "main", 1, $category[0] + ($category[0] < 80 ? 80 : -50), 93)
					ControlClick($HostWnd, "", "", "main", 1, $category[0] + 10, 93)
					ControlClick($HostWnd, "", "", "main", 1, 472 - ($MarketCriterion * 28), 91)
					If PixelGetColor(549, 334, WinGetHandle($HostWnd)) = 0x0CDFFF Then
						_DebugLine("Waiting for the request to complete?")
						ControlClick($HostWnd, "", "", "main", 1, 409, 387)
						ContinueLoop
					EndIf
				Until 1
				While PixelGetColor(480, 170, WinGetHandle($HostWnd)) <> 0x237BD4
					Sleep(10)
				WEnd
				_DebugLine("Items on sale shown.")
				$matched = False
				For $i = 0 To 12
					If PixelGetColor(441, 143 + ($i * 28), WinGetHandle($HostWnd)) = 0x7F7F7F Then ContinueLoop
					If PixelGetColor(480, 170 + ($i * 28), WinGetHandle($HostWnd)) <> 0x237BD4 Then ExitLoop
					If $MarketHotItems = 4 And $MarketPurpleText = 4 And $MarketAnyItems = 4 Then $matched = True
					If $MarketAnyItems = 1 Or $MarketPurpleText = 1 Then Sleep(50)
					If Not $matched Then
						Select
							Case $MarketAnyItems = 4 And $MarketHotItems = 1 And $MarketPurpleText = 1
								PixelSearch(37, 167 + ($i * 28), 47, 174 + ($i * 28), 0xFF48FF, 0, 1, WinGetHandle($HostWnd))
								If (Not @error) And (PixelGetColor(25, 177, WinGetHandle($HostWnd)) = 0xEF0F0F Or _
										PixelGetColor(25, 177 + ($i * 28), WinGetHandle($HostWnd)) = 0xDD0000) Then $matched = True
							Case $MarketAnyItems = 1
								ContinueCase
							Case $MarketHotItems = 1
								If (PixelGetColor(25, 177, WinGetHandle($HostWnd)) = 0xEF0F0F Or _
										PixelGetColor(25, 177 + ($i * 28), WinGetHandle($HostWnd)) = 0xDD0000) Then $matched = True
								If $MarketAnyItems = 1 Then ContinueCase
							Case $MarketPurpleText = 1
								PixelSearch(37, 167 + ($i * 28), 47, 174 + ($i * 28), 0xFF48FF, 0, 1, WinGetHandle($HostWnd))
								If Not @error Then $matched = True
						EndSelect
					EndIf
					If $matched Then ExitLoop
				Next
				If $matched Then
					_DebugReportVar("Item number matches search criteria", $i)
					SplashSet("Đang mua vật phẩm ở hàng thứ " & StringFormat("%02i", $i + 1) & _
							@CRLF & "F1: Dừng auto" & _
							@CRLF & "Ctrl+F8: Trở về menu thiết đặt auto" & _
							@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
							@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
					ControlClick($HostWnd, "", "", "main", 1, 457, 169 + ($i * 28))
					While Not (PixelGetColor(585, 339, WinGetHandle($HostWnd)) = 0x0CDFFF Or PixelGetColor(548, 336, WinGetHandle($HostWnd)) = 0x0CDFFF)
						Sleep(10)
					WEnd
					If PixelGetColor(548, 336, WinGetHandle($HostWnd)) = 0x0CDFFF Then
						$success = 4
						_DebugLine("You own the desired item.")
						ControlClick($HostWnd, "", "", "main", 1, 409, 387)
					Else
						ControlClick($HostWnd, "", "", "main", 1, 351, 434)
						While PixelGetColor(548, 336, WinGetHandle($HostWnd)) <> 0x0CDFFF
							Sleep(10)
						WEnd
						ControlClick($HostWnd, "", "", "main", 1, 409, 387)
						While PixelGetColor(775, 468, WinGetHandle($HostWnd)) <> 0x189FF6
							Sleep(10)
						WEnd
						_DebugReportVar("Current lucci color checksum", PixelChecksum(620, 462, 755, 481, 1, WinGetHandle($HostWnd)))
						$success = (($currentlucci = PixelChecksum(620, 462, 755, 481, 2, WinGetHandle($HostWnd))) ? 2 : 1)
						_DebugLine($success = 2 ? "Cannot buy item." : "Bought an item!")
					EndIf
				Else
					$success = 3
					_DebugLine("No items match search criteria!")
				EndIf
				SplashSet(MarketResult($success) & _
						@CRLF & "F1: Dừng auto" & _
						@CRLF & "Ctrl+F8: Trở về menu thiết đặt auto" & _
						@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
						@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
				If $MarketPurchaseAlert = 1 And $success = 1 Then
					If MsgBox(64 + 4, "Đã mua vật phẩm", "Bạn có muốn tiếp tục chạy auto không?" _
							 & @CRLF & "Auto sẽ tiếp tục chạy sau 10 giây.", 10) = 7 Then Return AutoMarketGUI()
				EndIf
			WEnd
	EndSwitch
EndFunc

Func AutoLose()
	_DebugLine("AutoLose() started.")
	_DebugReportVar("Mode", $ActiveTab)
	_DebugReportVar("MoreMode", $MoreMode)
	HotKeySet("{f5}")
	HotKeySet("{f1}", "StopAuto")
	SplashSet("Auto đang chạy" & _
			@CRLF & "F1: Dừng auto" & _
			@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
			@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
	DismissAds($HostWnd, True)
	While Sleep(10)
		$looptime = TimerInit()
		Do
			ControlClick($HostWnd, "", "", "main", 2, 740, 50)
			ControlSend($HostWnd, "", "", "{enter}")
			Sleep(10)
		Until PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00C3F4
		ControlClick($HostWnd, "", "", "main", 2, 604, 520)
		ControlClick($HostWnd, "", "", "main", 1, 119 - 2, 610 - 23)
		$autoloops += 1
		SplashSet("Vòng lặp auto: " & Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
				"Số vòng lặp auto đã chạy: " & $autoloops & _
				@CRLF & "F1: Dừng auto" & _
				@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
				@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
		_DebugReportVar("AutoLose() loops", $autoloops)
		_DebugReportVar("Loop time", Round(TimerDiff($looptime) / 1000, 3))
	WEnd
EndFunc

Func AutoDicing()
	$FirstSwap = True
	_DebugLine("AutoDicing() started.")
	_DebugReportVar("Mode", $ActiveTab)
	_DebugReportVar("MoreMode", $MoreMode)
	HotKeySet("{f5}")
	HotKeySet("{f1}", "StopAuto")
	SplashSet("Auto đang chạy" & _
			@CRLF & "F1: Dừng auto" & _
			@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
			@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
	WinActivate($HostWnd)
	#cs
	$category = PixelSearch(252, 585, 462, 585, 0xDEB55A, 0, 1, WinGetHandle($HostWnd))
	If @error Then _
			Return (MsgBox(48 + 4, "Auto không thể chạy", "Không tìm thấy nhiệm vụ đảo báu vật." & @CRLF & _
			"Bạn có muốn trở về giao diện chọn auto không?" & @CRLF & _
			"Nếu không, auto sẽ dừng lại.") = 6) ? BackToGUI() : StopAuto()
	_DebugReportVar("Mode X", $category[0])
	#ce
	Do
		ControlClick($HostWnd, "", "", "main", 1, 300, 585)
		;ControlClick($HostWnd, "", "", "main", 1, 450, 585)
		ControlClick($HostWnd, "", "", "main", 1, 540 - 2, $FirstSwap ? 329 - 23 : 355 - 23)
		ControlClick($HostWnd, "", "", "main", 1, 636, 383)
		ControlSend($HostWnd, "", "", "{enter}")
		$FirstSwap = Not $FirstSwap
	Until 0 ;Not Sleep(10)
EndFunc

Func AutoQuestItem()
	_DebugLine("AutoQuestItem() started.")
	_DebugReportVar("Mode", $ActiveTab)
	_DebugReportVar("MoreMode", $MoreMode)
	HotKeySet("^{f5}")
	HotKeySet("^{f7}", "PauseAuto")
	HotKeySet("^{f8}", "StopAuto")
	SplashSet("Đang chờ trở về phòng" & _
			@CRLF & "Ctrl+F7: Tạm dừng" & _
			@CRLF & "Ctrl+F8: Dừng auto" & _
			@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
			@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
	MouseAway()
	WinActivate($HostWnd)
	While PixelGetColor(211, 49, WinGetHandle($HostWnd)) <> 0x00c3f4
		Sleep(10)
	WEnd
	_DebugLine("Inside room.")
	SplashSet("Auto đang chạy" & _
			@CRLF & "Ctrl+F7: Tạm dừng" & _
			@CRLF & "Ctrl+F8: Dừng auto" & _
			@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
			@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
	SelectMap($HostWnd)
	_DebugLine("Now changing teams.")
	Do
		ControlClick($HostWnd, "", "", "main", 1, 589 - 2, 320 - 23)
		Sleep(10)
	Until PixelGetColor(586, 290, WinGetHandle($HostWnd)) = 0x24FFFF
	_DebugLine("Teams changed.")
	While SendKeepActive("")
		PushStart($HostWnd)
		While Not (PixelGetColor(762, 581, WinGetHandle($HostWnd)) = 0x9BE8FF Or PixelGetColor(762, 581, WinGetHandle($HostWnd)) = 0x0EC0FF)
			Sleep(10)
		WEnd
		_DebugLine("The game has started!")
		SendKeepActive($HostWnd)
		Sleep(500)
		Do
			_DebugLine("Down-Up phase started.")
			Send("{left down}")
			Sleep(2750)
			Send("{left up}")
			_DebugLine("Left 2750")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{up down}")
			Sleep(1250)
			Send("{up up}")
			_DebugLine("Up 1250")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{left down}")
			Sleep(500)
			Send("{left up}")
			_DebugLine("Left 500")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{up down}")
			Sleep(1250)
			Send("{up up}")
			_DebugLine("Up 1250")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{right down}")
			Sleep(1250)
			Send("{right up}")
			_DebugLine("Right 1250")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{up down}")
			Sleep(1250)
			Send("{up up}")
			_DebugLine("Up 1250")
			Sleep(500)
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			_DebugLine("Up-Down phase started.")
			Send("{down down}")
			Sleep(1250)
			Send("{down up}")
			_DebugLine("Down 1250")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{left down}")
			Sleep(1250)
			Send("{left up}")
			_DebugLine("Left 1250")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{down down}")
			Sleep(1250)
			Send("{down up}")
			_DebugLine("Down 1250")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{right down}")
			Sleep(500)
			Send("{right up}")
			_DebugLine("Right 500")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{down down}")
			Sleep(1250)
			Send("{down up}")
			_DebugLine("Down 1250")
			If PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4 Then ExitLoop
			Send("{right down}")
			Sleep(2750)
			Send("{right up}")
			_DebugLine("Right 2750")
			Sleep(500)
		Until PixelGetColor(211, 49, WinGetHandle($HostWnd)) = 0x00c3f4
		_DebugLine("Back to room.")
	WEnd
EndFunc

Func AutoPushStart()
	_DebugLine("AutoPushStart() started.")
	_DebugReportVar("MoreMode", $MoreMode)
	_DebugReportVar("Mode", $ActiveTab)
	HotKeySet("^{f5}")
	HotKeySet("^{f8}", "StopAuto")
	SplashSet("Auto đang chạy" & _
			@CRLF & "Ctrl+F8: Dừng auto" & _
			@CRLF & "Ctrl+F9: Thoát khỏi auto" & _
			@CRLF & "Ctrl+F12: Trở về giao diện chọn auto")
	Do
		ControlClick($HostWnd, "", "", "main", 2, 567, 520)
		Sleep(100)
		ControlClick($HostWnd, "", "", "main", 1, 409, 387)
	Until Not Sleep(900)
EndFunc

Func AutoNeedle()
	_DebugLine("AutoNeedle() started.")
	_DebugReportVar("Mode", $ActiveTab)
	HotKeySet("^{f5}")
	HotKeySet("^{f6}")
	HotKeySet("^{f7}", "PauseAuto")
	HotKeySet("^{f8}", "StopAuto")
	HotKeys()
	Timer(-1)
	If $w < 1 Then $w = 1
	_DebugReportVar("Starting with session", $w)
	For $i = $w To $windows
		$w = $i
		_DebugReportVar("Session", $w)
		For $FirstSwap = 1 To (($LevelSpinMode And $pl[2 * $i] <> "") ? 2 : 1)
			SplashSet("Đang tiến hành (" & StringFormat("%02i", $i) & "/" & StringFormat("%02i", $windows) & ")" & _
					(($LevelSpinMode And $pl[2 * $i] <> "") ? ($FirstSwap = 1 ? " (1P)" : " (2P)") : "") & @CRLF _
					 & "Ctrl+F7: Tạm dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F8: Dừng auto (đăng nhập lại ở lần hiện tại)" & @CRLF & _
					"Ctrl+F10: Làm lại lần đăng nhập trước" & @CRLF & "Ctrl+F11: Bỏ qua lần đăng nhập này" & @CRLF & _
					"Ctrl+F12: Dừng && trở về giao diện chọn auto")
			If Not (WinExists("[CLASS:Crazy Arcade]")) Then
				_DebugLine('"[CLASS:Crazy Arcade]" window does not exist!')
				While WinClose("login fail")
					Sleep(100)
				WEnd
				While WinClose("Kết nối thất bại.")
					Sleep(100)
				WEnd
				NewWindow()
			Else
				MouseAway()
				WinActivate("[CLASS:Crazy Arcade]")
				_DebugLine("Taking to the login screen.")
				ControlSend("[CLASS:Crazy Arcade]", "", "", "{up 25}{enter}")
				Timer(40000)
				Do
					ControlSend("[CLASS:Crazy Arcade]", "", "", "{enter}")
					ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 119 - 2, 610 - 23)
					Sleep(10)
				Until PixelGetColor(384, 580, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x25B1FA
				Timer(-1)
			EndIf
			($LevelSpinMode <> 1) ? PostLogin("[CLASS:Crazy Arcade]", $pl[2 * $i - 1], $pass[2 * $i - 1], $pl[2 * $i], $pass[2 * $i]) : _
					PostLogin("[CLASS:Crazy Arcade]", $pl[2 * $i - 2 + $FirstSwap], $pass[2 * $i - 2 + $FirstSwap], "", "")
			PeriodicDisCheck(True)
			DismissAds("[CLASS:Crazy Arcade]", False)
			If $LevelSpinMode = 1 And PixelGetColor(348, 582, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x1851A5 Then
				Do
					ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 348, 582)
					Sleep(10)
				Until PixelGetColor(259, 415, WinGetHandle("[CLASS:Crazy Arcade]")) = 0xDADADA And _
						PixelGetColor(560, 173, WinGetHandle("[CLASS:Crazy Arcade]")) = 0xFF2929
				If PixelGetColor(402, 333, WinGetHandle("[CLASS:Crazy Arcade]")) = 0xFFC119 Then
					ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 402, 333)
					Sleep(Random(500, 1000, 1))
					Do
						ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 402, 333)
						Sleep(10)
					Until PixelGetColor(561, 390, WinGetHandle("[CLASS:Crazy Arcade]")) = 0xFF2121
				EndIf
				DismissAds("[CLASS:Crazy Arcade]", False)
			EndIf
			_DebugLine('Pushing "Shop" button.')
			Timer(30000)
			Do
				ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 180 - 2, 610 - 23)
				Sleep(10)
			Until PixelGetColor(775, 590, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0xFF5B36
			Timer(-1)
			If $pl[2 * $i] <> "" And $LevelSpinMode <> 1 Then
				ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 540 - 2, 329 - 23)
				_DebugLine("Player 1 selected.")
			EndIf
			For $c = 0 To Bit($pl[2 * $i] <> "" And $LevelSpinMode <> 1)
				Timer(30000)
				While PixelGetColor(511, 27, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0xE7E478
					Sleep(10)
					If PixelGetColor(512, 198, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF Then
						Switch MsgBox(3 + 48, "Lỗi tiến hành auto", _
								"Đã xảy ra ngắt kết nối với máy chủ khi vào cửa hàng." & @CRLF & _
								"Bạn có muốn quay về giao diện chọn auto để chọn lại kênh không?" & @CRLF & _
								"Auto sẽ tự chọn kênh khác thay thế sau 10 giây." & @CRLF & @CRLF & _
								"Yes/Có: Trở về giao diện chọn auto" & @CRLF & _
								"No/Không: Tự động chọn kênh thay thế" & @CRLF & _
								"Cancel/Hủy bỏ: Giữ nguyên kênh hiện tại", 10)
							Case 6
								Return BackToGUI()
							Case 2
								Return AutoNeedle()
							Case Else
								$ChannelName = ($ChannelName = "TD-01") ? ($svrHN = 1 ? "TD-09" : "TD-14") : _
										("TD-" & StringFormat("%02i", Number(StringRight($ChannelName, 2)) - 1))
								Return AutoNeedle()
						EndSwitch
					EndIf
				WEnd
				KillTimers()
				Timer(-1)
				PeriodicDisCheck(True)
				WinActivate("[CLASS:Crazy Arcade]")
				_DebugLine("Entered shop.")
				Timer(30000)
				Do
					_DebugLine("Searching for Free Needles...")
					Do
						ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 504, 77)
						Sleep(10)
					Until PixelGetColor(409, 322, WinGetHandle("[CLASS:Crazy Arcade]")) = 0xFFFFFF
					ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 409 - 2, 342 - 23)
					SendKeepActive("[CLASS:Crazy Arcade]")
					Send("Kim miêÞn phiì", 1)
					Send("{enter}")
					SendKeepActive("")
					While PixelGetColor(420, 283, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0x09438D
						Sleep(10)
						If PixelGetColor(512, 198, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF Then
							_DebugLine("Not found. Typing error?")
							ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
							ContinueLoop 2
						EndIf
					WEnd
				Until 1
				Timer(-1)
				Timer(30000)
				ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 224, 224)
				While PixelGetColor(454, 453, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0x0CDFFF
					Sleep(10)
				WEnd
				Timer(-1)
				_DebugLine("Buying prompt displayed.")
				Timer(30000)
				ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 302 - 2, 467 - 23)
				While PixelGetColor(512, 198, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0x0CDFFF
					Sleep(10)
				WEnd
				Timer(-1)
				_DebugLine("Bought!")
				ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
				Sleep(500)
				If PixelGetColor(512, 198, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF Then _
						ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
				Timer(30000)
				While PixelGetColor(511, 27, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0xE7E478
					Sleep(10)
					If PixelGetColor(384, 580, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x25B1FA Then Return AutoNeedle()
				WEnd
				Timer(-1)
				_DebugLine("Back to shop.")
				Timer(30000)
				While 1
					ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 663, 587)
					Sleep(10)
					If PixelGetColor(512, 198, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF Then
						Do
							ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
							Sleep(10)
							If PixelGetColor(384, 580, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x25B1FA Then _
									Return AutoNeedle()
						Until PixelGetColor(510, 31, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0DDFFF
						ExitLoop
					ElseIf PixelGetColor(510, 31, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0DDFFF Then
						ExitLoop
					EndIf
				WEnd
				Timer(-1)
				_DebugLine('"My Items" page opened.')
				If PixelGetColor(42, 271, WinGetHandle("[CLASS:Crazy Arcade]")) = 0xFF89B1 Then
					_DebugLine('Feeding current pet.')
					Timer(30000)
					While PixelGetColor(51, 301, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0x003DA1
						ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 65, 310)
						Sleep(10)
						If PixelGetColor(248, 284, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF Then
							ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
							ExitLoop
						EndIf
					WEnd
					_DebugLine('The current pet cannot eat more.')
					Timer(-1)
				EndIf
				Timer(30000)
				For $slot = 0 To 15
					Switch Int($slot / 4)
						Case 0
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 44, 475)
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 85, 475)
						Case 1
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 44, 475)
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 118, 475)
						Case 2
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 155, 475)
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 85, 475)
						Case 3
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 155, 475)
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 118, 475)
					EndSwitch
					Sleep(100)
					Switch Mod($slot, 4)
						Case 0
							If PixelChecksum(45, 355, 85, 387, 2, WinGetHandle("[CLASS:Crazy Arcade]")) = 2272606487 Then ExitLoop ;first slot empty
							_DebugLine("First slot of the current page not empty.")
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 66, 374)
						Case 1
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 138, 374)
						Case 2
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 66, 434)
						Case 3
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 138, 434)
					EndSwitch
					_DebugReportVar("Selected slot", $slot)
					Sleep(100)
					If PixelGetColor(42, 271, WinGetHandle("[CLASS:Crazy Arcade]")) = 0xFF89B1 Then
						_DebugLine("Feeding selected pet.")
						While PixelGetColor(51, 301, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0x003DA1
							ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 65, 310)
							Sleep(10)
							If PixelGetColor(248, 284, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF Then
								ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
								ExitLoop
							EndIf
						WEnd
					ElseIf PixelGetColor(248, 284, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF Then
						_DebugLine("Not a living pet.")
						ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
					EndIf
				Next
				Timer(-1)
				_DebugLine("Pet feeding completed.")
				ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc 2}")
				Timer(30000)
				While PixelGetColor(511, 27, WinGetHandle("[CLASS:Crazy Arcade]")) <> 0xE7E478
					Sleep(10)
				WEnd
				Timer(-1)
				If $pl[2 * $i] <> "" And $c = 0 And $LevelSpinMode <> 1 Then
					_DebugLine("Getting out of shop.")
					ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 119 - 2, 610 - 23)
					Timer(30000)
					While PixelGetColor(460, 59, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x004979
						Sleep(10)
					WEnd
					Timer(-1)
					_DebugLine("Back to lobby.")
					DismissAds("[CLASS:Crazy Arcade]", False)
					_DebugLine('Pushing "Shop" button.')
					Timer(30000)
					Do
						ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 2, 180 - 2, 610 - 23)
						Sleep(10)
					Until PixelGetColor(493, 214, WinGetHandle("[CLASS:Crazy Arcade]")) = 0x0CDFFF
					Timer(-1)
					ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 540 - 2, 355 - 23)
					_DebugLine("Player 2 selected.")
				EndIf
			Next
			ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 119 - 2, 610 - 23)
			KillTimers()
			_DebugReportVar("End of session", $w)
			_DebugReportVar("Session time", Round(TimerDiff($looptime) / 1000, 3))
		Next
	Next
	$w = 1
	WinFade($splashwindow, "", 200, 0, -25)
	GUIDelete($splashwindow)
	HotKeySet("^{f7}")
	HotKeySet("+{pause}")
	HotKeySet("^{f8}")
	HotKeySet("^{f12}")
	_DebugLine("AutoNeedle() completed.")
	Switch MsgBox(3 + 32, "Hoàn thành (" & StringFormat("%02i", $windows) & " lần đăng nhập)", "Bạn có muốn giữ lại cửa sổ Boom đang mở không?" _
			 & @CRLF & @CRLF & "Yes/Có: Giữ cửa sổ Boom, trở về giao diện chọn auto" & _
			@CRLF & "No/Không: Đóng cửa sổ Boom, thoát khỏi auto" & @CRLF & "Cancel/Hủy bỏ: Giữ cửa sổ Boom, thoát khỏi auto")
		Case 6 ;yes
			BackToGUI()
		Case 7 ;no
			WinClose("[CLASS:Crazy Arcade]")
			Exit 0
		Case 2 ;cancel
			Exit 0
	EndSwitch
EndFunc

Func AutoNeedleUndoSession()
	$w -= 1
	_DebugReportVar("Back to session", $w)
	Return AutoNeedle()
EndFunc

Func AutoNeedleSkipSession()
	$w += 1
	_DebugReportVar("Skipping to session", $w)
	Return AutoNeedle()
EndFunc

Func AutoLadder()
	Local $master, $slave, $dummy, $color[4], $vs[3] ;0 for 1-2, 1 for 1-3, 2 for 2-3
	_DebugLine("AutoLadder() started.")
	_DebugReportVar("Mode", $ActiveTab)
	HotKeySet("^{f6}")
	HotKeySet("^{f7}", "PauseAuto")
	HotKeySet("^{f8}", "StopAuto")
	HotKeys()
	PeriodicDisCheck(True)
	If $windows = 3 Then
		$FirstSwap = 0
		For $i = 1 To $windows
			WinMove("b" & $i, "", ($i - 1) * 50, 0, Default, Default)
		Next
		For $i = 0 To 2
			$vs[$i] = False
		Next
	Else
		$FirstSwap = False ;swap between 2 channels
	EndIf
	$currentmap = 0
	$mapchange = 0
	SplashSet("Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
			"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
	While MouseAway()
		$looptime = TimerInit()
		$master = 0
		$slave = 0
		$dummy = 0
		For $i = $windows To 1 Step -1
			WinActivate("b" & $i)
			Timer(30000)
			While PixelGetColor(494, 261, WinGetHandle("b" & $i)) <> 16777215
				For $c = $i To 1 Step -1
					ControlClick("b" & $c, "", "", "main", 2, 284, 59)
				Next
				Sleep(10)
			WEnd
			SendKeepActive("b" & $i)
			Send($DefaultRoomName, 1)
			If 1 Then
				ControlClick("b" & $i, "", "", "main", 1, 394, 289)
				ControlClick("b" & $i, "", "", "main", 1, 320, 289)
			Else
				ControlClick("b" & $i, "", "", "main", 1, 468, 289)
				ControlClick("b" & $i, "", "", "main", 1, 482, 343)
				ControlClick("b" & $i, "", "", "main", 2, 482, 317)
				Send($pwd, 1)
			EndIf
			Send("{enter}")
			SendKeepActive("")
			Timer(-1)
			_DebugLine('"b' & $i & '" created room.')
		Next
		For $i = $windows To 1 Step -1
			WinActivate("b" & $i)
			Timer(30000)
			While PixelGetColor(211, 49, WinGetHandle("b" & $i)) <> 0x00c3f4
				#cs
				For $c = 3 To ($InviteMode = 1) ? 1 : $windows
					ControlSend("b" & $c, "", "", "!1{enter 2}")
				Next
				#ce
				Sleep(10)
			WEnd
			Timer(-1)
			_DebugLine('"b' & $i & '" inside room.')
		Next
		If $currentmap <> $mapchange Then
			For $i = 1 To $windows
				WinActivate("b" & $i)
				Timer(30000)
				Do
					ControlClick("b" & $i, "", "", "main", 2, 713, 453)
					Sleep(10)
				Until PixelGetColor(623, 331, WinGetHandle("b" & $i)) = 0x0CDFFF
				Timer(-1)
				ControlClick("b" & $i, "", "", "main", 1, 461, 183)
				If $mapchange <> 1 Then ControlClick("b" & $i, "", "", "main", 1, 461, $mapchange)
				ControlSend("b" & $i, "", "", "{enter}")
				_DebugLine('"b' & $i & '" selected map.')
				Timer(30000)
				While PixelGetColor(211, 49, WinGetHandle("b" & $i)) <> 0x00c3f4
					#cs
					For $c = 3 To ($InviteMode = 1) ? 1 : $windows
						ControlSend("b" & $c, "", "", "!1{enter 2}")
					Next
					#ce
					Sleep(10)
				WEnd
				Timer(-1)
				_DebugLine('"b' & $i & '" is back to room.')
			Next
			$currentmap = $mapchange
		EndIf
		;PreAuto2()
		#cs
		For $i = 3 To $windows
			WinActivate("b" & $i)
			While PixelGetColor(211, 49, WinGetHandle("b" & $i)) <> 0x00c3f4
				Sleep(10)
			WEnd
			If PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x1481FD Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x045537 Then
				Timer(30000)
				Do
					ControlClick("b" & $i, "", "", "main", 1, 731, 537)
					Sleep(10)
				Until PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004AA9 Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004924
				Timer(-1)
				_DebugLine('Automatic ready is turned on for "b' & $i & '".')
			EndIf
			WinActivate("b" & ($i - 2))
			If $InviteMode = 1 Then ControlSend("b" & ($i - 2), "", "", "{enter 2}")
			Timer(30000)
			While Not (PixelGetColor(249, 244, WinGetHandle("b" & ($i - 2))) = 0xFFE000 Or PixelGetColor(381, 244, WinGetHandle("b" & ($i - 2))) = 0xFFE000)
				Sleep(10)
			WEnd
			Timer(-1)
			_DebugLine('"b' & $i & '" is ready to go!')
		Next
		#ce
		Sleep(10)
		WinActivate("b1")
		Timer(30000)
		Do
			If $windows = 3 Then
				For $i = $windows To (($vs[0] And $vs[1]) ? 2 : 1) Step -1
					ControlClick("b" & $i, "", "", "main", 2, 604, 520)
				Next
			Else
				ControlClick("b2", "", "", "main", 2, 604, 520)
				ControlClick("b1", "", "", "main", 2, 604, 520)
			EndIf
			If $windows = 3 Then MouseClick("menu", 400, -1, 1, 0)
			;MouseMove(400, -1, 0)
			;MouseDown("main")
			_DebugLine('Obtaining pixel colors.')
			Sleep(500)
			For $i = $windows To 1 Step -1
				$color[$i] = PixelGetColor(789, 20, WinGetHandle("b" & $i))
			Next
			If $windows = 3 Then
				Select
					Case $color[2] <> 0x046CC8 And $color[3] <> 0x046CC8
						$dummy = 1
						$master = 2
						$slave = 3
					Case $color[2] <> 0x046CC8 And $color[3] = 0x046CC8
						$dummy = 3
						$master = 1
						$slave = 2
					Case $color[2] = 0x046CC8 And $color[3] <> 0x046CC8
						$dummy = 2
						$master = 1
						$slave = 3
				EndSelect
				If $master <> 0 Then
					MouseUp("main")
					MouseAway()
					_DebugReportVar('Master', $master)
					_DebugReportVar('Slave', $slave)
					_DebugReportVar('Dummy', $dummy)
					ControlClick("b" & $dummy, "", "", "main", 1, 119 - 2, 610 - 23)
					While 1
						ControlSend("b" & $dummy, "", "", "{enter}")
						Sleep(10)
						If PixelGetColor(762, 581, WinGetHandle("b" & $dummy)) = 0x9BE8FF Or _
								PixelGetColor(762, 581, WinGetHandle("b" & $dummy)) = 0x0EC0FF Then
							ControlClick("b" & $dummy, "", "", "main", 2, 742, 583)
							ControlSend("b" & $dummy, "", "", "{up 25}{enter}")
							ExitLoop
						ElseIf PixelGetColor(775, 590, WinGetHandle("b" & $dummy)) = 0xFF5B36 Then
							ExitLoop
						EndIf
					WEnd
					WinActivate("b" & $slave)
					While Not (PixelGetColor(762, 581, WinGetHandle("b" & $slave)) = 0x9BE8FF Or _
							PixelGetColor(762, 581, WinGetHandle("b" & $slave)) = 0x0EC0FF)
						Sleep(10)
					WEnd
					$timinghandle = TimerInit()
					_DebugLine('Checking if label colors match.')
					$matched = False
					WinActivate("b" & $master)
					While Not (PixelGetColor(762, 581, WinGetHandle("b" & $master)) = 0x9BE8FF Or _
							PixelGetColor(762, 581, WinGetHandle("b" & $master)) = 0x0EC0FF)
						Sleep(10)
					WEnd
					$color[1] = PixelChecksum(730, 98, 778, 137, 2, WinGetHandle("b" & $master))
					_DebugReportVar('Master label pixel checksum', $color[1])
					WinActivate("b" & $slave)
					Do
						$color[2] = PixelChecksum(730, 98, 778, 137, 2, WinGetHandle("b" & $slave))
						_DebugReportVar('Slave label pixel checksum', $color[2])
						If $color[1] = $color[2] Then $matched = True
						Sleep(10)
					Until TimerDiff($timinghandle) >= 4000 Or $matched
					If $matched Then
						SplashSet(LadderMapMessage() & @CRLF & "Các đội khớp nhau" & @CRLF & LadderLoops() & @CRLF & _
								"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
								"Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
								"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
						_DebugLine('Colors match! Waiting for slave.')
						WinActivate("b" & $slave)
						While PixelGetColor(762, 581, WinGetHandle("b" & $slave)) <> 0x9BE8FF
							If PixelGetColor(789, 20, WinGetHandle("b" & $slave)) = 0x046CC8 Then
								ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
								ExitLoop
							EndIf
							Sleep(10)
						WEnd
						While 1
							Sleep(10)
							If PixelGetColor(762, 581, WinGetHandle("b" & $slave)) = 0x9BE8FF Or _
									PixelGetColor(762, 581, WinGetHandle("b" & $slave)) = 0x0EC0FF Then
								ControlClick("b" & $slave, "", "", "main", 2, 742, 583)
								ControlSend("b" & $slave, "", "", "{up 25}{enter}")
								ExitLoop
							ElseIf PixelGetColor(211, 49, WinGetHandle("b" & $slave)) = 0x00c3f4 Then
								ControlClick("b" & $slave, "", "", "main", 1, 119 - 2, 610 - 23)
								ExitLoop
							ElseIf PixelGetColor(775, 590, WinGetHandle("b" & $slave)) = 0xFF5B36 Then
								ExitLoop
							EndIf
						WEnd
						WinActivate("b" & $master)
						Do
							If (PixelGetColor(423, 82, WinGetHandle("b" & $master)) = 0 And _
									PixelGetColor(391, 58, WinGetHandle("b" & $master)) = 16777215) Or _ ;normal win
									(PixelGetColor(470, 56, WinGetHandle("b" & $master)) = 0 And _
									PixelGetColor(440, 59, WinGetHandle("b" & $master)) = 16777215) Then ;perfect win
								ControlClick("b" & $master, "", "", "main", 2, 742, 583)
								ControlSend("b" & $master, "", "", "{up 25}{enter}")
								ExitLoop
							ElseIf PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then
								ControlClick("b" & $master, "", "", "main", 1, 119 - 2, 610 - 23)
								ExitLoop
							EndIf
						Until Not Sleep(10)
						$LadderWins += 1
						_DebugReportVar("Ladder wins", $LadderWins)
						$vs[(($master = 1) ? ($slave - 2) : 2)] = True
					Else
						SplashSet(LadderMapMessage() & @CRLF & "Các đội không khớp nhau!" & @CRLF & LadderLoops() & @CRLF & _
								"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
								"Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
								"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
						_DebugLine('Colors do not match!')
						For $i = $slave To $master Step ($master - $slave)
							WinActivate("b" & $i)
							If PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then
								ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
							Else
								ControlClick("b" & $i, "", "", "main", 2, 742, 583)
								ControlSend("b" & $i, "", "", "{up 25}{enter}")
							EndIf
						Next
					EndIf
					For $i = 1 To $windows
						If PixelGetColor(789, 20, WinGetHandle("b" & $i)) = 0x046CC8 Then ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
					Next
					_DebugLine("End of game.")
					ExitLoop
				EndIf
			Else
				Select
					Case $color[1] = 0x046CC8 And $color[2] <> 0x046CC8
						MouseUp("main")
						MouseAway()
						WinActivate("b1")
						_DebugLine('Now exiting "b1".')
						For $i = 1 To $windows - 1 Step 2
							ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
						Next
						Do
							Sleep(10)
							ControlSend("b1", "", "", "{enter}")
							If PixelGetColor(762, 581, WinGetHandle("b1")) = 0x9BE8FF Or _
									PixelGetColor(762, 581, WinGetHandle("b1")) = 0x0EC0FF Then ContinueCase
						Until PixelGetColor(775, 590, WinGetHandle("b1")) = 0xFF5B36
						Timer(-1)
						For $i = 2 To $windows
							WinActivate("b" & $i)
							_DebugLine('Now exiting "b' & $i & '".')
							While 1
								ControlSend("b" & $i, "", "", "{enter}")
								Sleep(10)
								If PixelGetColor(762, 581, WinGetHandle("b" & $i)) = 0x9BE8FF Or _
										PixelGetColor(762, 581, WinGetHandle("b" & $i)) = 0x0EC0FF Then
									ControlClick("b" & $i, "", "", "main", 2, 742, 583)
									ControlSend("b" & $i, "", "", "{up 25}{enter}")
									ExitLoop
								ElseIf PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then
									ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
									ExitLoop
								ElseIf PixelGetColor(775, 590, WinGetHandle("b" & $i)) = 0xFF5B36 Then
									ExitLoop
								EndIf
							WEnd
						Next
						ExitLoop
					Case PixelGetColor(762, 581, WinGetHandle("b1")) = 0x9BE8FF Or PixelGetColor(762, 581, WinGetHandle("b1")) = 0x0EC0FF
						Timer(-1)
						MouseUp("main")
						MouseAway()
						$timinghandle = TimerInit()
						While PixelGetColor(672, 18, WinGetHandle("b1")) <> 0x0A61B6
							Sleep(10)
						WEnd
						_DebugLine('Checking if label colors match.')
						$matched = False
						WinActivate("b1")
						$color[1] = PixelChecksum(730, 98, 778, 137, 2, WinGetHandle("b1"))
						_DebugReportVar('Master label pixel checksum', $color[1])
						WinActivate("b2")
						Do
							$color[2] = PixelChecksum(730, 98, 778, 137, 2, WinGetHandle("b2"))
							_DebugReportVar('Slave label pixel checksum', $color[2])
							If $color[1] = $color[2] Then $matched = True
							Sleep(10)
						Until TimerDiff($timinghandle) >= 3000 Or $matched
						If $matched Then
							SplashSet(LadderMapMessage() & @CRLF & "Các đội khớp nhau" & @CRLF & LadderLoops() & @CRLF & _
									"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
									"Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
									"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
							_DebugLine('Colors match! Waiting for slave.')
							For $i = 2 To $windows Step 2
								WinActivate("b" & $i)
								While PixelGetColor(762, 581, WinGetHandle("b" & $i)) <> 0x9BE8FF
									If PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then
										ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
										ExitLoop
									EndIf
									Sleep(10)
								WEnd
								_DebugLine('Now exiting "b' & $i & '".')
								ControlClick("b" & $i, "", "", "main", 2, 742, 583)
								ControlSend("b" & $i, "", "", "{up 25}{enter}")
							Next
							For $i = 1 To $windows - 1 Step 2
								_DebugLine('Now exiting "b' & $i & '".')
								WinActivate("b" & $i)
								Timer(30000)
								Do
									If (PixelGetColor(423, 82, WinGetHandle("b" & $i)) = 0 And _
											PixelGetColor(391, 58, WinGetHandle("b" & $i)) = 16777215) Or _ ;normal win
											(PixelGetColor(470, 56, WinGetHandle("b" & $i)) = 0 And _
											PixelGetColor(440, 59, WinGetHandle("b" & $i)) = 16777215) Then ;perfect win
										ControlClick("b" & $i, "", "", "main", 2, 742, 583)
										ControlSend("b" & $i, "", "", "{up 25}{enter}")
										ExitLoop
									ElseIf PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then
										ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
										ExitLoop
									EndIf
								Until Not Sleep(10)
								Timer(-1)
							Next
							$LadderWins += 1
							_DebugReportVar("Ladder wins", $LadderWins)
						Else
							SplashSet(LadderMapMessage() & @CRLF & "Các đội không khớp nhau!" & @CRLF & LadderLoops() & @CRLF & _
									"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
									"Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
									"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
							_DebugLine('Colors do not match!')
							For $i = $windows To 1 Step -1
								WinActivate("b" & $i)
								If PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then
									ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
								Else
									ControlClick("b" & $i, "", "", "main", 2, 742, 583)
									ControlSend("b" & $i, "", "", "{up 25}{enter}")
								EndIf
							Next
						EndIf
						For $i = 1 To $windows
							If PixelGetColor(789, 20, WinGetHandle("b" & $i)) = 0x046CC8 Then ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
						Next
						_DebugLine("End of game.")
						ExitLoop
				EndSelect
			EndIf
		Until Not Sleep(500)
		Sleep(100)
		If $windows = 3 Then
			_DebugReportVar("Versus status", $vs)
		Else
			For $i = 1 To $windows
				DismissAds("b" & $i, False)
				Sleep(100)
				ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
			Next
			$FirstSwap = Not $FirstSwap
			_DebugReportVar("First swap", $FirstSwap)
			AssignChannel($FirstSwap ? $ChannelName : $ChannelName2)
			_DebugReportVar("Channel selected", $FirstSwap ? $ChannelName : $ChannelName2)
			For $i = 1 To $windows
				WinActivate("b" & $i)
				Timer(30000)
				While PixelGetColor(775, 590, WinGetHandle("b" & $i)) <> 0xFF5B36
					Sleep(10)
				WEnd
				While PixelGetColor(513, 470, WinGetHandle("b" & $i)) = 0x09A0F4 And PixelGetColor(539, 156, WinGetHandle("b" & $i)) = 0xBB0F18
					ControlClick("b" & $i, "", "", "main", 1, 605 - 2, 57 - 23)
					Sleep(100)
					ControlClick("b" & $i, "", "", "main", 1, 597, 187)
					Sleep(10)
				WEnd
				Do
					ControlClick("b" & $i, "", "", "main", 1, 597, 187)
					Sleep(10)
				Until PixelGetColor(597, 187, WinGetHandle("b" & $i)) = 0xFCC08B
				Timer(-1)
				ControlClick("b" & $i, "", "", "main", 2, 535 - 30 + (30 * $ChannelPage), 527)
			    _DebugReportVar("Channel page number", $ChannelPage)
				Timer(30000)
				While 1
					ControlSend("b" & $i, "", "", "{ESC}")
					Sleep(10)
					ControlClick("b" & $i, "", "", "main", 2, $chanx, $chany)
					While Not (PixelGetColor(552, 274, WinGetHandle("b" & $i)) = 0x0CDFFF Or PixelGetColor(499, 324, WinGetHandle("b" & $i)) = 0x1687D8)
						Sleep(10)
					WEnd
					If PixelGetColor(499, 324, WinGetHandle("b" & $i)) = 0x1687D8 Then ExitLoop
				WEnd
				Timer(-1)
			Next
			_DebugLine("Connecting to channel completed.")
		EndIf
		For $i = 1 To $windows
			DismissAds("b" & $i, True)
		Next
		If $windows = 3 And $vs[0] And $vs[1] And $vs[2] Then
			_DebugLine("Reinitializing team detection.")
			For $i = 0 To 2
				$vs[$i] = False
			Next
		EndIf
		_DebugLine('A new map will be chosen if "Auto" map mode is selected.')
		If $LadderRandomizedMap Then LadderMapAuto()
		$autoloops += 1
		If 0 Then
			$pwd = ""
			For $i = 1 To 4
				$pwd &= Chr(Random(97, 122, 1))
			Next
			SplashSet(LadderMapMessage() & @CRLF & "Mật khẩu phòng: " & $pwd & " - Vòng lặp auto: " & _
					Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & LadderLoops() & @CRLF & _
					"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
					"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
		Else
			SplashSet(LadderMapMessage() & @CRLF & _
					"Vòng lặp auto: " & Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & LadderLoops() & @CRLF & _
					"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
					"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
		EndIf
		_DebugReportVar("AutoLadder() loops", $autoloops)
		_DebugReportVar("Loop time", Round(TimerDiff($looptime) / 1000, 3))
	WEnd
EndFunc

Func AutoZombieWinMulti()
	If $HostMode = 1 Then
		Return AutoWho()
	Else
		SplashSet("Auto đang chạy" & @CRLF & "Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
				"Ctrl+F12: Dừng && trở về giao diện chọn auto")
		While SendKeepActive("[CLASS:Crazy Arcade]")
			Sleep(1000)
			Send("{space down}{lshift down}{rshift down}")
			Sleep(100)
			Send("{space up}{lshift up}{rshift up}")
			Sleep(900)
		WEnd
		SendKeepActive("")
		Return KillAndRefresh()
	EndIf
EndFunc

Func AutoWho()
	_DebugLine("AutoWho() started.")
	_DebugReportVar("Mode", $ActiveTab)
	_DebugReportVar("AutoWho() Mode", $whomode)
	HotKeySet("^{f6}")
	HotKeySet("^{f7}", "PauseAuto")
	HotKeySet("^{f8}", "StopAuto")
	HotKeys()
	PeriodicDisCheck(True)
	If $login = 1 Then
		$looptime = TimerInit()
		SelectMap()
	EndIf
	Local $giftboxes = False
	SplashSet("Auto đang chạy" & @CRLF & "Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
			"Ctrl+F12: Dừng && trở về giao diện chọn auto")
	If $whomode = 0 Then
		WinMove("b1", "", 0, 0, Default, Default)
		For $i = 2 To $windows
			WinMove("b" & $i, "", 150, 0, Default, Default)
		Next
	EndIf
	While MouseAway()
		For $i = 2 To $windows
			Timer(30000)
			WinActivate("b" & $i)
			While PixelGetColor(211, 49, WinGetHandle("b" & $i)) <> 0x00c3f4
				Sleep(10)
			WEnd
			If $whomode <> 2 And ($i = 4 Or ($i = 3 And Not ($pl[1] <> "" And $pl[2] <> "" And $pl[3] <> "" And $pl[4] <> ""))) Then
				If PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004AA9 Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004924 Then
					ControlClick("b" & $i, "", "", "main", 1, 731, 537)
					ControlClick("b" & $i, "", "", "main", 1, 604, 520)
					Sleep(100)
				EndIf
				Do
					If $pl[2 * $i] <> "" Then ControlClick("b" & $i, "", "", "menu", 1, 536, 296)
					ControlClick("b" & $i, "", "", "main", 1, 536, 296)
					Sleep(10)
				Until (($pl[2 * $i] <> "") ? ((PixelGetColor(548, 287, WinGetHandle("b" & $i)) = 0x24FFFF And _
						PixelGetColor(548, 299, WinGetHandle("b" & $i)) = 0x7fff00) Or _
						(PixelGetColor(533, 286, WinGetHandle("b" & $i)) = 0x24ffff And _
						PixelGetColor(535, 299, WinGetHandle("b" & $i)) = 0x7fff00)) : _
						(PixelGetColor(548, 287, WinGetHandle("b" & $i)) = 0x24FFFF Or PixelGetColor(533, 286, WinGetHandle("b" & $i)) = 0x24FFFF))
				_DebugLine("Teams changed.")
				Sleep(200)
				ControlClick("b" & $i, "", "", "main", 1, 604, 520)
			EndIf
			If ($whomode = 2 Or $i = 2 Or ($i = 3 And $pl[1] <> "" And $pl[2] <> "" And $pl[3] <> "" And $pl[4] <> "")) And _
					(PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x1481FD Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x045537) Then
				Do
					ControlClick("b" & $i, "", "", "main", 1, 731, 537)
					Sleep(10)
				Until PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004AA9 Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004924
				_DebugLine('Automatic ready activated for "b' & $i & '".')
			EndIf
			Timer(-1)
		Next
		WinActivate("b1")
		If $whomode <> 2 And $InviteMode = 1 Then ControlSend("b1", "", "", "{enter 2}")
		Sleep(100)
		Timer(60000)
		Switch $whomode
			Case 2 ;Zombie Mode
				PushStart("b1")
				Timer(-1)
				While 1
					Timer(120000)
					Do
						For $i = 1 To $windows
							WinActivate("b" & $i)
							SendKeepActive("b" & $i)
							Send("{space down}{lshift down}{rshift down}")
							Sleep(100)
							Send("{space up}{lshift up}{rshift up}")
							SendKeepActive("")
						Next
						If $windows = 1 Then Sleep(100)
						WinActivate("b1")
						;ControlClick("b1", "", "", "main", 2, 604, 520)
					Until PixelGetColor(211, 49, WinGetHandle("b1")) = 0x00c3f4
					_DebugLine("Back to room.")
					Timer(30000)
					PushStart("b1")
					Timer(-1)
					$autoloops += 1
					SplashSet("Vòng lặp auto: " & _
							Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
							"Số vòng lặp auto đã chạy: " & $autoloops & @CRLF & _
							"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
					_DebugReportVar("AutoWho() (zombie mode) loops", $autoloops)
					$looptime = TimerInit()
				WEnd
			Case 1 ;Event Mode
				PushStart("b1")
				Timer(-1)
				While 1
					Timer(30000)
					While Not (PixelGetColor(762, 581, WinGetHandle("b1")) = 0x9BE8FF Or PixelGetColor(762, 581, WinGetHandle("b1")) = 0x0EC0FF)
						Sleep(10)
					WEnd
					Timer(-1)
					$timinghandle = TimerInit()
					_DebugLine('The game has started! Now waiting for "b1"...')
					While TimerDiff($timinghandle) < 20000
						Sleep(100)
					WEnd
					_DebugLine('"b1" committing suicide.')
					Do
						SendKeepActive("b" & $i)
						Send("{space down}{lshift down}{rshift down}")
						Sleep(100)
						Send("{space up}{lshift up}{rshift up}")
						SendKeepActive("")
						Sleep(100)
					Until PixelGetColor(211, 49, WinGetHandle("b1")) = 0x00c3f4
					;ControlSend("b1", "", "", "{up 25}{enter}")
					;Sleep(500)
					_DebugLine("Back to room.")
					If PixelGetColor(250, 223, WinGetHandle("b1")) = 0xFF77C7 Or _
							PixelGetColor(144, 223, WinGetHandle("b1")) = 0xFF77C7 Then ;heart point gift event
						For $c = 38 To 356 Step 106
							For $i = 1 To $windows
								ControlClick("b" & $i, "", "", "main", 2, $c, 223)
								ControlClick("b" & $i, "", "", "main", 2, $c, 367)
							Next
						Next
					EndIf
					Timer(30000)
					PushStart("b1")
					Timer(-1)
					$autoloops += 1
					SplashSet("Vòng lặp auto: " & _
							Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
							"Số vòng lặp auto đã chạy: " & $autoloops & @CRLF & _
							"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
					_DebugReportVar("AutoWho() (zombie mode) loops", $autoloops)
					$looptime = TimerInit()
				WEnd
			Case Else
				Do
					ControlClick("b1", "", "", "main", 1, 409, 387)
					Sleep(50)
					ControlClick("b1", "", "", "main", 2, 604, 520)
					ControlClick("b1", "", "", "main", 1, 119 - 2, 610 - 23)
					Sleep(200)
					If PixelGetColor(554, 265, WinGetHandle("b1")) = 0x0CDFFF Or PixelGetColor(554, 265, WinGetHandle("b1")) = 0x046CC8 _
							Then ContinueLoop
				Until PixelGetColor(211, 49, WinGetHandle("b1")) <> 0x00C3F4 And PixelGetColor(211, 49, WinGetHandle("b1")) <> 0x009CC3
				Timer(-1)
				WinActivate("b2")
				Timer(30000)
				Do
					ControlSend("b1", "", "", "{enter}")
					Sleep(10)
					If (PixelGetColor(27, 591, WinGetHandle("b1")) = 0x0094EC) Or (PixelGetColor(30, 585, WinGetHandle("b1")) = 0x0066A2) Then
						_DebugLine("The game has started!")
						ControlSend("b1", "", "", "{up 25}{enter}")
						Sleep(500)
						;WinActivate("b1")
					EndIf
				Until PixelGetColor(40, 247, WinGetHandle("b1")) = 0x90FF00
		EndSwitch
		Timer(-1)
		;DismissAds("b1", True)
		$pwd = ""
		For $i = 1 To 4
			$pwd &= Chr(Random(97, 122, 1))
		Next
		$autoloops += 1
		SplashSet("Mật khẩu phòng: " & $pwd & " - Vòng lặp auto: " & _
				Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
				"Số vòng lặp auto đã chạy: " & $autoloops & @CRLF & _
				"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
		_DebugReportVar("AutoWho() loops", $autoloops)
		_DebugReportVar("Loop time", Round(TimerDiff($looptime) / 1000, 3))
		$looptime = TimerInit()
		$matched = False
		For $i = 2 To $windows
			Timer(30000)
			WinActivate("b" & $i)
			If $giftboxes Then
				While PixelGetColor(305, 354, WinGetHandle("b" & $i)) <> 0xFF8A08
					ControlClick("b1", "", "", "main", 2, 284, 59)
					If (PixelGetColor(122, 119, WinGetHandle("b1")) = 16777215) Or (PixelGetColor(60, 119, WinGetHandle("b1")) = 16777215) Then
						Timer(-1)
						PreAutoCreateRoom()
						Timer(30000)
						$matched = True
						WinActivate("b" & $i)
					EndIf
					Sleep(10)
				WEnd
			EndIf
			If PixelGetColor(305, 354, WinGetHandle("b" & $i)) = 0xFF8A08 Then ;five gift boxes event
				$giftboxes = True
				For $c = 145 To 485 Step 85
					$timinghandle = TimerInit()
					For $iFlag = $i To $windows
						ControlClick("b" & $iFlag, "", "", "main", 2, $c, 450)
					Next
					While TimerDiff($timinghandle) < 100
						Sleep(10)
					WEnd
				Next
			EndIf
			Do
			    If Not $matched Then
					ControlClick("b1", "", "", "main", 2, 284, 59)
					If (PixelGetColor(122, 119, WinGetHandle("b1")) = 16777215) Or (PixelGetColor(60, 119, WinGetHandle("b1")) = 16777215) Then
						Timer(-1)
						PreAutoCreateRoom()
						Timer(30000)
						$matched = True
						WinActivate("b" & $i)
					EndIf
			    EndIf
				If (PixelGetColor(423, 82, WinGetHandle("b" & $i)) = 0 And PixelGetColor(391, 58, WinGetHandle("b" & $i)) = 16777215) Or _ ;normal win
						(PixelGetColor(421, 109, WinGetHandle("b" & $i)) = 0 And PixelGetColor(391, 101, WinGetHandle("b" & $i)) = 16777215) Or _ ;mission win
						(PixelGetColor(470, 56, WinGetHandle("b" & $i)) = 0 And PixelGetColor(440, 59, WinGetHandle("b" & $i)) = 16777215) Then ;perfect win
					ControlClick("b" & $i, "", "", "main", 2, 742, 583)
					ControlSend("b" & $i, "", "", "{up 25}{enter}")
					_DebugLine('"b' & $i & '" wins!')
					ExitLoop
				ElseIf PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then
					ControlClick("b" & $i, "", "", "main", 1, 119 - 2, 610 - 23)
					_DebugLine('"b' & $i & '" inside room.')
					ExitLoop
				EndIf
				If $whomode <> 2 Then
					If $pl[2] <> "" Then ControlClick("b1", "", "", "menu", 1, 589 - 2, 320 - 23)
					ControlClick("b1", "", "", "main", 1, 589 - 2, 320 - 23)
				EndIf
			Until Not Sleep(10)
			Timer(-1)
		Next
		WinActivate("b1")
		Timer(30000)
		While PixelGetColor(211, 49, WinGetHandle("b1")) <> 0x00c3f4
			Sleep(10)
		WEnd
		_DebugLine("Inside room.")
		PreAutoChangeTeams()
		Timer(-1)
		PreAuto2()
		_DebugLine("End of script loop.")
	WEnd
EndFunc

Func AutoExp()
	Local $dir[2][2] ;[player][segment]
	_DebugLine("AutoExp() started.")
	_DebugReportVar("Mode", $ActiveTab)
	_DebugReportVar("AutoExp() Mode", $expmode)
	HotKeySet("^{f6}")
	HotKeySet("^{f7}", "PauseAuto")
	HotKeySet("^{f8}", "StopAuto")
	HotKeys()
	PeriodicDisCheck(True)
	MouseAway()
	If $login = 1 Then
		$looptime = TimerInit()
		SelectMap()
	EndIf
	SplashSet("Auto đang chạy" & @CRLF & "Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & _
			"Ctrl+F12: Dừng && trở về giao diện chọn auto")
	For $i = 2 To $windows
		Timer(30000)
		WinActivate("b" & $i)
		While PixelGetColor(211, 49, WinGetHandle("b" & $i)) <> 0x00c3f4
			Sleep(10)
		WEnd
		If $expmode = 0 Then
			Switch $i
				Case 2, 4
					If PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004AA9 Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004924 Then _
							ControlClick("b" & $i, "", "", "main", 1, 604, 520)
					If $i = 2 Then
						Do
							ControlClick("b" & $i, "", "", "main", 1, 589 - 2, 320 - 23)
							Sleep(10)
						Until PixelGetColor(608, 287, WinGetHandle("b" & $i)) = 0x24ffff Or PixelGetColor(586, 290, WinGetHandle("b" & $i)) = 0x24ffff
					Else
						Do
							If $pl[8] <> "" Then ControlClick("b" & $i, "", "", "menu", 1, 537, 299)
							ControlClick("b" & $i, "", "", "main", 1, 537, 299)
							Sleep(10)
						Until PixelGetColor(551, 287, WinGetHandle("b" & $i)) = 0x24ffff And _
								(($pl[8] <> "") ? (PixelGetColor(551, 300, WinGetHandle("b" & $i)) = 0x7fff00) : True)
					EndIf
					_DebugLine("Teams changed.")
					Sleep(200)
					ControlClick("b" & $i, "", "", "main", 1, 604, 520)
			EndSwitch
		EndIf
		If PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x1481FD Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x045537 Then
			Do
				ControlClick("b" & $i, "", "", "main", 1, 731, 537)
				Sleep(10)
			Until PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004AA9 Or PixelGetColor(731, 537, WinGetHandle("b" & $i)) = 0x004924
			_DebugLine('Automatic ready activated for "b' & $i & '".')
		EndIf
		Timer(-1)
	Next
	Timer(60000)
	PushStart("b1")
	While Not (PixelGetColor(762, 581, WinGetHandle("b1")) = 0x9BE8FF Or PixelGetColor(762, 581, WinGetHandle("b1")) = 0x0EC0FF)
		Sleep(10)
	WEnd
	Timer(-1)
	_DebugLine("The game has started!")
	Switch $expmode
		Case 0
			While 1
				Timer(240000)
				$timinghandle = TimerInit()
				WinActivate("b1")
				SendKeepActive("b1")
				Send("{down down}{f down}")
				For $i = 1 To $windows
					ControlSend("b" & $i, "", "", "{down down}")
					If $pl[2 * $i] <> "" Then ControlSend("b" & $i, "", "", "{f down}")
				Next
				Sleep(6000)
				_DebugLine("Down 6000")
				Send("{down up}{f up}{left down}{d down}")
				For $i = 1 To $windows
					ControlSend("b" & $i, "", "", "{left down}")
					If $pl[2 * $i] <> "" Then ControlSend("b" & $i, "", "", "{d down}")
				Next
				Sleep(6000)
				Send("{left up}{d up}")
				_DebugLine("Left 6000")
				While TimerDiff($timinghandle) < 48000
					Sleep(100)
				WEnd
				ControlSend("b2", "", "", "{RSHIFT}")
				_DebugLine("Suicide bomb set.")
				While PixelGetColor(211, 49, WinGetHandle("b1")) <> 0x00c3f4
					Send("{right down}")
					Sleep(2000)
					Send("{right up}")
					_DebugLine("Right 2000")
					Sleep(1000)
					Send("{space}")
					Send("{RSHIFT}")
					_DebugLine("Required bomb set.")
					Send("{left down}")
					Sleep(2500)
					Send("{left up}")
					_DebugLine("Left 2500")
					Send("{space}")
					Send("{RSHIFT}")
					_DebugLine("Required bomb set.")
				WEnd
				Timer(-1)
				SendKeepActive("")
				_DebugLine("Inside room.")
				Sleep(500)
				Timer(30000)
				PushStart("b1")
				Timer(-1)
				$autoloops += 1
				SplashSet("Vòng lặp auto: " & _
						Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
						"Số vòng lặp auto đã chạy: " & $autoloops & @CRLF & _
						"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
				_DebugReportVar("AutoExp() loops", $autoloops)
				_DebugReportVar("Loop time", Round(TimerDiff($looptime) / 1000, 3))
				$looptime = TimerInit()
				Timer(30000)
				While Not (PixelGetColor(762, 581, WinGetHandle("b1")) = 0x9BE8FF Or PixelGetColor(762, 581, WinGetHandle("b1")) = 0x0EC0FF)
					Sleep(10)
				WEnd
				Timer(-1)
			WEnd
		Case 1
			Timer(120000)
			While 1
				$zombietimer = TimerInit()
				Do
					For $i = $windows To 2 Step -1
						WinActivate("b" & $i)
						SendKeepActive("b" & $i)
						Send("{space down}{lshift down}{rshift down}")
						Sleep(100)
						Send("{space up}{lshift up}{rshift up}")
						SendKeepActive("")
						_DebugLine('"b' & $i & '" set suicide bombs.')
						If PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Or TimerDiff($zombietimer) >= 31000 Then ExitLoop 2
						Sleep(900)
					Next
				Until 0
				WinActivate("b1")
				SendKeepActive("b1")
				While PixelGetColor(211, 49, WinGetHandle("b1")) <> 0x00c3f4
					Send("{space down}{lshift down}{rshift down}")
					Sleep(100)
					Send("{space up}{lshift up}{rshift up}")
					Sleep(900)
				WEnd
				SendKeepActive("")
				If PixelGetColor(211, 49, WinGetHandle("b1")) = 0x00c3f4 Then
					Timer(-1)
					_DebugLine("Inside room.")
					Timer(30000)
					PushStart("b1")
					Timer(-1)
					$autoloops += 1
					SplashSet("Vòng lặp auto: " & _
							Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
							"Số vòng lặp auto đã chạy: " & $autoloops & @CRLF & _
							"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
					_DebugReportVar("AutoExp() loops", $autoloops)
					_DebugReportVar("Loop time", Round(TimerDiff($looptime) / 1000, 3))
					$looptime = TimerInit()
					Timer(120000)
				Else
					SendKeepActive("b1")
					Send("{LSHIFT}")
					SendKeepActive("")
					_DebugLine('Player 1 of "b1" set suicide bomb.')
					Sleep(1000)
				EndIf
			WEnd
		Case 2
			While 1
				Timer(120000)
				$zombietimer = TimerInit()
				While TimerDiff($zombietimer) < 33000
					Sleep(100)
				WEnd
				WinActivate("b1")
				SendKeepActive("b1") ;SendKeepActive("[CLASS:#32769]") ;desktop window (tested on Windows NT 6.1)
				Do
					Send("{down down}{f down}")
					For $i = 1 To $windows
						ControlSend("b" & $i, "", "", "{down down}")
						If $pl[2 * $i] <> "" Then ControlSend("b" & $i, "", "", "{f down}")
					Next
					Sleep(4000)
					Send("{down up}{f up}")
					_DebugLine("Down 4000")
					If PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4 Then ExitLoop
					Send("{left down}{d down}")
					For $i = 1 To $windows
						ControlSend("b" & $i, "", "", "{left down}")
						If $pl[2 * $i] <> "" Then ControlSend("b" & $i, "", "", "{d down}")
					Next
					Sleep(4000)
					Send("{left up}{d up}")
					_DebugLine("Left 4000")
				Until PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00c3f4
				Timer(-1)
				_DebugLine("Back to room.")
				SendKeepActive("")
				Timer(30000)
				PushStart("b1")
				Timer(-1)
				$autoloops += 1
				SplashSet("Vòng lặp auto: " & _
						Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
						"Số vòng lặp auto đã chạy: " & $autoloops & @CRLF & _
						"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
				_DebugReportVar("AutoExp() loops", $autoloops)
				_DebugReportVar("Loop time", Round(TimerDiff($looptime) / 1000, 3))
				$looptime = TimerInit()
				Timer(30000)
				While Not (PixelGetColor(762, 581, WinGetHandle("b1")) = 0x9BE8FF Or PixelGetColor(762, 581, WinGetHandle("b1")) = 0x0EC0FF)
					Sleep(10)
				WEnd
				Timer(-1)
				_DebugLine("The game has started!")
			WEnd
		Case 3
			While 1
				Do
					$zombieposition = 0
					$zombieplayer = 0
					_DebugLine("Searching for zombie position started.")
					$zombietimer = TimerInit()
					Timer(45000)
					While $zombieposition = 0 Or $zombieplayer = 0
						For $i = 1 To $windows
							WinActivate("b" & $i)
							Select
								Case PixelGetColor(54, 546, WinGetHandle("b" & $i)) = 0xAD00E4 ;1P zombie
									$zombieplayer = 2 * $i - 1
									_DebugReportVar("Zombie player", $zombieplayer)
								Case PixelGetColor(584, 547, WinGetHandle("b" & $i)) = 0xAD00E4 ;2P zombie
									$zombieplayer = 2 * $i
									_DebugReportVar("Zombie player", $zombieplayer)
							EndSelect
							Select
								Case PixelGetColor(33, 27, WinGetHandle("b" & $i)) = 0xA1BBAE ;top left
									$zombieposition = 1
									_DebugLine("Zombie position: 1 (top left)")
								Case PixelGetColor(313, 30, WinGetHandle("b" & $i)) = 0xA1BBAE ;top middle
									$zombieposition = 2
									_DebugLine("Zombie position: 2 (top middle)")
								Case PixelGetColor(593, 30, WinGetHandle("b" & $i)) = 0xA1BBAE ;top right
									$zombieposition = 3
									_DebugLine("Zombie position: 3 (top right)")
								Case PixelGetColor(33, 269, WinGetHandle("b" & $i)) = 0x8AA195 ;middle left
									$zombieposition = 4
									_DebugLine("Zombie position: 4 (middle left)")
								Case PixelGetColor(592, 265, WinGetHandle("b" & $i)) = 0x8AA195 ;middle right
									$zombieposition = 5
									_DebugLine("Zombie position: 5 (middle right)")
								Case PixelGetColor(33, 509, WinGetHandle("b" & $i)) = 0x8AA195 ;bottom left
									$zombieposition = 6
									_DebugLine("Zombie position: 6 (bottom left)")
								Case PixelGetColor(313, 510, WinGetHandle("b" & $i)) = 0x8AA195 ;bottom middle
									$zombieposition = 7
									_DebugLine("Zombie position: 7 (bottom middle)")
								Case PixelGetColor(593, 508, WinGetHandle("b" & $i)) = 0x8AA195 ;bottom right
									$zombieposition = 8
									_DebugLine("Zombie position: 8 (bottom right)")
							EndSelect
							If PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00C3F4 Then ExitLoop 3
						Next
					WEnd
					Timer(-1)
					WinActivate("b1")
					If PixelGetColor(211, 49, WinGetHandle("b1")) = 0x00C3F4 Then ExitLoop
					If $zombieplayer <> 2 Then
						SendKeepActive("b1")
						Switch $zombieposition
							Case 1, 4 ;top left & middle left
								Send("{right down}")
								Sleep(1000)
								Send("{right up}")
								_DebugLine("Dodging: Right 1000")
							Case 2 ;top middle
								Send("{down down}")
								Sleep(3000)
								Send("{down up}")
								_DebugLine("Dodging: Down 3000")
								Send("{right down}")
								Sleep(500)
								Send("{right up}")
								_DebugLine("Dodging: Right 500")
							Case 3, 5 ;top right & middle right
								Send("{left down}")
								Sleep(500)
								Send("{left up}")
								_DebugLine("Dodging: Left 500")
								Send("{up down}")
								Sleep(500)
								Send("{up up}")
								_DebugLine("Dodging: Up 500")
							Case 6, 7, 8 ;bottom positions
								Send("{up down}")
								Sleep(1000)
								Send("{up up}")
								_DebugLine("Dodging: Up 1000")
						EndSwitch
						SendKeepActive("")
					EndIf
					WinActivate("b" & Ceiling($zombieplayer / 2))
					If PixelGetColor(211, 49, WinGetHandle("b" & Ceiling($zombieplayer / 2))) = 0x00C3F4 Then ExitLoop
					SendKeepActive("b" & Ceiling($zombieplayer / 2))
					Switch $zombieposition
						Case 1, 2
							$dir[0][0] = "left"
							$dir[1][0] = "d"
							$dir[0][1] = "up"
							$dir[1][1] = "r"
						Case 3, 5
							$dir[0][0] = "right"
							$dir[1][0] = "g"
							$dir[0][1] = "up"
							$dir[1][1] = "r"
						Case 4, 6
							$dir[0][0] = "left"
							$dir[1][0] = "d"
							$dir[0][1] = "down"
							$dir[1][1] = "f"
						Case 7, 8
							$dir[0][0] = "right"
							$dir[1][0] = "g"
							$dir[0][1] = "down"
							$dir[1][1] = "f"
					EndSwitch
					Switch $zombieposition
						Case 1, 3, 6, 8
							_DebugLine("Zombie is already in optimal position!")
						Case 4
							Send("{" & $dir[Mod($zombieplayer, 2)][1] & " down}")
							Sleep(3000)
							Send("{" & $dir[Mod($zombieplayer, 2)][1] & " up}")
							_DebugLine("Zombie ambush: F/Down 3000")
						Case 2
							Send("{" & $dir[Mod($zombieplayer, 2)][0] & " down}")
							Sleep(3000)
							Send("{" & $dir[Mod($zombieplayer, 2)][0] & " up}")
							_DebugLine("Zombie ambush: D/Left 3000")
						Case 5
							Send("{" & $dir[Mod($zombieplayer, 2)][1] & " down}")
							Sleep(3000)
							Send("{" & $dir[Mod($zombieplayer, 2)][1] & " up}")
							_DebugLine("Zombie ambush: R/Up 3000")
						Case 7
							Send("{" & $dir[Mod($zombieplayer, 2)][0] & " down}")
							Sleep(3000)
							Send("{" & $dir[Mod($zombieplayer, 2)][0] & " up}")
							_DebugLine("Zombie ambush: G/Right 3000")
					EndSwitch
					If PixelGetColor(211, 49, WinGetHandle("b" & Ceiling($zombieplayer / 2))) = 0x00C3F4 Then ExitLoop
					_DebugLine("Zombie is ready to ambush!")
					SendKeepActive("b2")
					For $c = 0 To 2
						Send("{" & $dir[0][Mod($c, 2)] & " down}{" & $dir[1][Mod($c, 2)] & " down}")
						For $i = $windows To 1 Step -1
							If $i <> 1 Then ControlSend("b" & $i, "", "", "{" & $dir[0][Mod($c, 2)] & " down}")
							If $pl[2 * $i] <> "" Then ControlSend("b" & $i, "", "", "{" & $dir[1][Mod($c, 2)] & " down}")
						Next
						Sleep(3500)
						Send("{" & $dir[0][Mod($c, 2)] & " up}{" & $dir[1][Mod($c, 2)] & " up}")
						_DebugLine(_StringProper($dir[0][Mod($c, 2)]) & " 3500")
						If PixelGetColor(211, 49, WinGetHandle("b" & $i)) = 0x00C3F4 Then ExitLoop 2
					Next
					SendKeepActive("")
					If $zombieplayer <> 2 Then
						_DebugLine("Waiting until the desired time.")
						WinActivate("b1")
						Do
							Sleep(10)
							If PixelGetColor(211, 49, WinGetHandle("b1")) = 0x00C3F4 Then ExitLoop 2
						Until TimerDiff($zombietimer) >= 38000
						SendKeepActive("b1")
						For $c = 0 To 2
							Send("{" & $dir[0][Mod($c, 2)] & " down}")
							Sleep(3500)
							Send("{" & $dir[0][Mod($c, 2)] & " up}")
							_DebugLine(_StringProper($dir[0][Mod($c, 2)]) & " 3500")
							If PixelGetColor(211, 49, WinGetHandle("b1")) = 0x00C3F4 Then ExitLoop 2
						Next
					EndIf
				Until 1
				SendKeepActive("")
				WinActivate("b1")
				Timer(90000)
				PushStart("b1")
				Timer(-1)
				$autoloops += 1
				SplashSet("Vòng lặp auto: " & _
						Round(TimerDiff($looptime) / 1000, 3) & "s" & @CRLF & _
						"Số vòng lặp auto đã chạy: " & $autoloops & @CRLF & _
						"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto")
				_DebugReportVar("AutoExp() loops", $autoloops)
				_DebugReportVar("Loop time", Round(TimerDiff($looptime) / 1000, 3))
				$looptime = TimerInit()
				Timer(30000)
				While PixelGetColor(762, 581, WinGetHandle("b1")) = 0x9BE8FF Or PixelGetColor(762, 581, WinGetHandle("b1")) = 0x0EC0FF
					Sleep(10)
				WEnd
				Timer(-1)
			WEnd
	EndSwitch
EndFunc

Func MusicWarning()
	HotKeySet("!^+m")
	ControlSend("[CLASS:Crazy Arcade]", "", "", "{f10 3}")
	For $c = 1 To 3
		ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 400, 144) ;volume 0
		Sleep(1000)
		ControlClick("[CLASS:Crazy Arcade]", "", "", "main", 1, 555, 144) ;volume 5
		Sleep(1000)
	Next
	ControlSend("[CLASS:Crazy Arcade]", "", "", "{esc}")
	Return HotKeySet("!^+m", "MusicWarning")
EndFunc

Func ExecuteDebug()
	HotKeySet("!^+d")
	Local $cmd = InputBox("Debug Mode", "Enter an expression to evaluate." & @CRLF & _
			"Misuse may break the program execution." & @CRLF & "In that case, please restart the program.")
	If @error Then Return HotKeySet("!^+d", "ExecuteDebug")
	Local $time = TimerInit(), $exec = Execute($cmd), $error = @error, $extended = @extended
	$time = Round(TimerDiff($time) / 1000, 9)
	MsgBox(64, "Result", $cmd & @CRLF & $exec & @CRLF & "Type: " & VarGetType($exec) & @CRLF & _
			"Error: " & $error & @CRLF & "Extended: " & $extended & @CRLF & "Time: " & $time & "s")
	Return HotKeySet("!^+d", "ExecuteDebug")
EndFunc

#Region MiscLadderFuncs
Func LadderCamp08()
	$LadderRandomizedMap = False
	$mapchange = 197
	Return LadderMapStatus()
EndFunc
Func LadderBattleship14()
	$LadderRandomizedMap = False
	$mapchange = 211
	Return LadderMapStatus()
EndFunc
Func LadderVillage10()
	$LadderRandomizedMap = False
	$mapchange = 225
	Return LadderMapStatus()
EndFunc
Func LadderMap01()
	$LadderRandomizedMap = False
	$mapchange = 239
	Return LadderMapStatus()
EndFunc
Func LadderMap02()
	$LadderRandomizedMap = False
	$mapchange = 253
	Return LadderMapStatus()
EndFunc
Func LadderMap03()
	$LadderRandomizedMap = False
	$mapchange = 267
	Return LadderMapStatus()
EndFunc
Func LadderMap04()
	$LadderRandomizedMap = False
	$mapchange = 281
	Return LadderMapStatus()
EndFunc
Func LadderMap05()
	$LadderRandomizedMap = False
	$mapchange = 295
	Return LadderMapStatus()
EndFunc
Func LadderMapRandom()
	$LadderRandomizedMap = False
	$mapchange = 1
	Return LadderMapStatus()
EndFunc
Func LadderMapAuto()
	$LadderRandomizedMap = True
	$oldmap = $mapchange
	Do
		$mapchange = 183 + (14 * Random(1, 8, 1))
	Until $mapchange <> $oldmap
	Return LadderMapStatus()
EndFunc
Func LadderMapStatus()
	SplashSet(LadderMapMessage() & @CRLF & (($windows > 2) ? ("Mật khẩu phòng: " & $pwd & @CRLF) : "") & _
			"Ctrl+F7: Tạm dừng - Ctrl+F8: Dừng - Ctrl+F9: Thoát" & @CRLF & "Ctrl+F12: Dừng && trở về giao diện chọn auto" & @CRLF & _
			"Bản đồ: Alt+Ctrl+D/T/N/R/A/số: DT08/TC14/NL10/Random/Tự chuyển/Siêu cấp")
	Return _DebugReportVar("Map Y", $mapchange)
EndFunc
Func LadderMapMessage()
	Local $mapname = ""
	Switch $mapchange
		Case 1
			$mapname = "Ngẫu nhiên"
		Case 197
			$mapname = "Doanh trại 08"
		Case 211
			$mapname = "Thuyền chiến 14"
		Case 225
			$mapname = "Ngôi làng 10"
		Case 239, 253, 267, 281, 295
			$mapname = "Siêu cấp " & StringFormat("%02i", ($mapchange - 225) / 14)
	EndSwitch
	If $mapname = "" Then
		Return ""
	ElseIf $LadderRandomizedMap Then
		Return ("Bản đồ: Tự động chuyển - " & $mapname)
	Else
		Return ("Bản đồ: " & $mapname)
	EndIf
EndFunc
#EndRegion MiscLadderFuncs
