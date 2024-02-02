program TwilioConsole;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  {$IFDEF MSWINDOWS} WinAPI.Windows, {$ENDIF}
  System.JSON,
  System.Net.HttpClient;


const
  {$IFDEF MSWINDOWS}       LibName = 'TwilioSMS.dll';
  {$ELSEIF DEFINED(MACOS)} LibName = 'libTwilioSMS.dylib';
  {$ELSEIF DEFINED(LINUX)} LibName = 'libTwilioSMS.so';
  {$ENDIF}

  TwilioAccount = '<YOUR OWN TWILIO ACCOUNT>';
  TwilioPassword = '<YOUR TWILIO PASSWORD>';
  FromPhone = '<Phone with Areacode>';
  ToPhone = '<Phone with Areacode>';
type
  TTwilioSMSSendFunc = function (const AccountSID, Password, FromPhone, ToPhone, Msg: string): string; stdcall;
var
  TwilioLibHandle: HModule;
  SendSMS: TTwilioSMSSendFunc;
  response: string;
begin
  TwilioLibHandle := LoadLibrary(LibName);
  if TwilioLibHandle = 0 then
    Writeln('Could not load Twilio SMS library: ' + LibName)
  else begin
    @SendSMS := GetProcAddress(TwilioLibHandle, 'SendTwilioSMS');

    {$IFDEF MSWINDOWS}
    response := SendSMS(TwilioAccount, TwilioPassword, FromPhone, ToPhone, 'Hello SMS - from Windows');
    {$ELSEIF DEFINED(MACOS)}
    response := SendSMS(TwilioAccount, TwilioPassword, FromPhone, ToPhone, 'Hello SMS - from Mac');
    {$ELSEIF DEFINED(LINUX)}
    response := SendSMS(TwilioAccount, TwilioPassword, FromPhone, ToPhone, 'Hello SMS - from Linux');
    {$ENDIF}

    Writeln('Twilio SMS Response: ' + response);

    Writeln('Press ENTER to exit.');
    Readln;
  end;
end.
