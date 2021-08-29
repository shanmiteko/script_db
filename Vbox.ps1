# VirtualBox����Ŀ¼
$VBOX = "D:\VirtualBox"
# �������
$VM = "openSUSE"

####################################��������####################################
# http://blog.vichamp.com/2017/02/27/show-or-hide-windows/
# requires -Version 5
# this enum works in PowerShell 5 only
# in earlier versions, simply remove the enum,
# and use the numbers for the desired window state
# directly

Enum ShowStates
{
  Hide = 0
  Normal = 1
  Minimized = 2
  Maximized = 3
  ShowNoActivateRecentPosition = 4
  Show = 5
  MinimizeActivateNext = 6
  MinimizeNoActivate = 7
  ShowNoActivate = 8
  Restore = 9
  ShowDefault = 10
  ForceMinimize = 11
}


# the C#-style signature of an API function (see also www.pinvoke.net)
$code = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'

# add signature as new type to PowerShell (for this session)
$type = Add-Type -MemberDefinition $code -Name myAPI -PassThru

# access a process
# (in this example, we are accessing the current PowerShell host
#  with its process ID being present in $pid, but you can use
#  any process ID instead)
$process = Get-Process -Id $PID

# get the process window handle
$hwnd = $process.MainWindowHandle

# apply a new window size to the handle, i.e. hide the window completely
$type::ShowWindowAsync($hwnd, [ShowStates]::Minimized)
####################################��������####################################

####################################����VBox####################################
Add-Type -AssemblyName PresentationCore,PresentationFramework

try {
    $VMs = Invoke-Expression "$VBOX\VBoxManage list vms"
    $RVMs = Invoke-Expression "$VBOX\VBoxManage list runningvms"
} catch {
    [void] [System.Windows.MessageBox]::Show( "δ�ҵ�VirtualBox", "����VBox��������", "OK", "Error" )
    Exit
}

if($VMs.Contains($VM)) {
    if(!$RVMs -or !$RVMs.Contains($VM)) {
        $OPT = [Int] [System.Windows.MessageBox]::Show( "���������޽���VBox�����-$VM", "���������", "OKCancel", "Info" )
        switch($OPT){
            1 {
                $Result = Invoke-Expression "$VBOX\VBoxManage startvm $VM -type headless"
                [void] [System.Windows.MessageBox]::Show( "�ɹ�����", "VBox", "OK", "Info" )
            }
            2 {}
        }
    } else {
        $OPT = [Int] [System.Windows.MessageBox]::Show( "�޽���VBox�����-${VM}��������,�Ƿ�ر���", "VBox", "OKCancel", "Info" )
        switch($OPT){
            1 {
                $Result = Invoke-Expression "$VBOX\VBoxManage controlvm $VM poweroff"
                [void] [System.Windows.MessageBox]::Show( "�ɹ��ر�", "VBox", "OK", "Info" )
            }
            2 {}
        }
    }
} else {
    [void] [System.Windows.MessageBox]::Show( "δ�ҵ������-$VM", "�������������", "OK", "Error" )
}
####################################����VBox####################################