on error resume next

'SINCRONIZA HORARIO ESTAÇÃO x SERVIDOR
wshShell.Run "NET TIME \\athena /SET /Y", 0, True

'LIMPA UNIDADES DE REDE
Set WSHNetwork = WScript.CreateObject("WScript.Network")
on error resume next
WSHNetwork.RemoveNetworkDrive "G:", True, True
WSHNetwork.RemoveNetworkDrive "H:", True, True
WSHNetwork.RemoveNetworkDrive "I:", True, True
WSHNetwork.RemoveNetworkDrive "J:", True, True
WSHNetwork.RemoveNetworkDrive "K:", True, True
WSHNetwork.RemoveNetworkDrive "L:", True, True
WSHNetwork.RemoveNetworkDrive "M:", True, True
WSHNetwork.RemoveNetworkDrive "N:", True, True
WSHNetwork.RemoveNetworkDrive "O:", True, True
WSHNetwork.RemoveNetworkDrive "P:", True, True
WSHNetwork.RemoveNetworkDrive "Q:", True, True
WSHNetwork.RemoveNetworkDrive "R:", True, True
WSHNetwork.RemoveNetworkDrive "S:", True, True
WSHNetwork.RemoveNetworkDrive "T:", True, True
WSHNetwork.RemoveNetworkDrive "U:", True, True
WSHNetwork.RemoveNetworkDrive "V:", True, True
WSHNetwork.RemoveNetworkDrive "X:", True, True
WSHNetwork.RemoveNetworkDrive "Y:", True, True
WSHNetwork.RemoveNetworkDrive "w:", True, True
WSHNetwork.RemoveNetworkDrive "Z:", True, True
WScript.DisconnectObject WSHNetwork
'FIM DO LIMPA UNIDADES

Dim ADSysInfo, CurrentUser, strGroups, wshNetwork, WshShell

Set oShell = CreateObject("Shell.Application")
Set ADSysInfo = CreateObject("ADSystemInfo")
Set CurrentUser = GetObject("LDAP://" & ADSysInfo.UserName)
Set wshNetwork = CreateObject("WScript.Network")
strGroups = LCase(Join(CurrentUser.MemberOf,"**"))
If InStr(strGroups, "informatica") Then
WshNetwork.RemoveNetworkDrive "I:"
wshNetwork.MapNetworkDrive "I:", "\\athena\informatica"
End If
If InStr(strGroups, "public") Then
WshNetwork.RemoveNetworkDrive "P:"
wshNetwork.MapNetworkDrive "P:", "\\athena\public"
End If
If InStr(strGroups, "comercial") Then
WshNetwork.RemoveNetworkDrive "T:"
wshNetwork.MapNetworkDrive "T:", "\\zentakus\comercial"
End If
If InStr(strGroups, "administracao") Then
WshNetwork.RemoveNetworkDrive "Z:"
wshNetwork.MapNetworkDrive "Z:", "\\zentakus\administracao"
End If
If InStr(strGroups, "vendas") Then
WshNetwork.RemoveNetworkDrive "V:"
wshNetwork.MapNetworkDrive "V:", "\\zentakus\vendas"
End If
If InStr(strGroups, "nqbt") Then
WshNetwork.RemoveNetworkDrive "N:"
wshNetwork.MapNetworkDrive "N:", "\\zentakus\nqbt"
End If
'Set WshShell = WScript.CreateObject("WScript.Shell")
oShell.NameSpace("Y:").Self.Name = "informatica"
oShell.NameSpace("P:").Self.Name = "public"
oShell.NameSpace("T:").Self.Name = "comercial"
oShell.NameSpace("Z:").Self.Name = "administracao"
oShell.NameSpace("V:").Self.Name = "vendas"
oShell.NameSpace("N:").Self.Name = "nqbt"
wscript.quit