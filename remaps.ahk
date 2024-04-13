*CapsLock::
{
    Send "{LControl down}"
}

*CapsLock up::
{
    Send "{LControl Up}"

    if (A_PriorKey=="CapsLock"){
	if (A_TimeSincePriorHotkey == 0)
		Suspend "1"
		Send "{Esc}"
		Suspend "0"
	}
}

f4::
{
    Run "C:\Program Files\WezTerm\wezterm-gui.exe"
}
