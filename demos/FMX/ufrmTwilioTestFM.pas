unit ufrmTwilioTestFM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation, FMX.Edit;

type
  TTwilioSMSSendFunc = function (const AccountSID, Password, FromPhone, ToPhone, Msg: string): string; stdcall;
  TfrmTwilioTestFM = class(TForm)
    HeaderToolBar: TToolBar;
    lblToolBar: TLabel;
    GestureManager: TGestureManager;
    tabCtrlTwilioMain: TTabControl;
    tabTwilioText: TTabItem;
    tabTwilioConfig: TTabItem;
    edtTwilioAccountSID: TEdit;
    edtTwilioAccountPassword: TEdit;
    lblTwilioAccountSID: TLabel;
    lblTwilioPassword: TLabel;
    lblTwillioPhoneNumber: TLabel;
    edtTwilioPhoneNumber: TEdit;
    lblRecipientPhoneNumber: TLabel;
    edtRecipientPhoneNumber: TEdit;
    btnTwilioSendText: TButton;
    lblMessageToSend: TLabel;
    edtTwilioTextMessage: TEdit;
    edtConfigFilename: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure edtTwilioExitSave(Sender: TObject);
  private
    const
      INISection_TwilioAccount = 'TwilioAccount';
      INIKey_AccountSID = 'AccountSID';
      INIKey_Password = 'Password';
      INIKey_FromPhone = 'FromPhone';
    function ConfigFilename: string;
    procedure SaveTwilioConfig;
    procedure LoadTwilioConfig;
  end;

var
  frmTwilioTestFM: TfrmTwilioTestFM;

implementation

{$R *.fmx}

uses
  System.IniFiles, System.IOUtils;

function TfrmTwilioTestFM.ConfigFilename: string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'TwilioTest.ini');
end;

procedure TfrmTwilioTestFM.edtTwilioExitSave(Sender: TObject);
begin
  SaveTwilioConfig;
end;

procedure TfrmTwilioTestFM.FormCreate(Sender: TObject);
begin
  tabCtrlTwilioMain.ActiveTab := tabTwilioText;
  LoadTwilioConfig;
end;

procedure TfrmTwilioTestFM.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if tabCtrlTwilioMain.ActiveTab <> tabCtrlTwilioMain.Tabs[tabCtrlTwilioMain.TabCount-1] then
        tabCtrlTwilioMain.ActiveTab := tabCtrlTwilioMain.Tabs[tabCtrlTwilioMain.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if tabCtrlTwilioMain.ActiveTab <> tabCtrlTwilioMain.Tabs[0] then
        tabCtrlTwilioMain.ActiveTab := tabCtrlTwilioMain.Tabs[tabCtrlTwilioMain.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

procedure TfrmTwilioTestFM.LoadTwilioConfig;
var
  ConfigFile: TIniFile;
begin
  ConfigFile := TIniFile.Create(ConfigFilename);
  try
    edtConfigFilename.Text := ConfigFilename;
    edtTwilioAccountSID.Text      := ConfigFile.ReadString(INISection_TwilioAccount, INIKey_AccountSID, EmptyStr);
    edtTwilioAccountPassword.Text := ConfigFile.ReadString(INISection_TwilioAccount, INIKey_Password, EmptyStr);
    edtTwilioPhoneNumber.Text     := ConfigFile.ReadString(INISection_TwilioAccount, INIKey_FromPhone, EmptyStr);
  finally
    ConfigFile.Free;
  end;
end;

procedure TfrmTwilioTestFM.SaveTwilioConfig;
var
  ConfigFile: TIniFile;
begin
  ConfigFile := TIniFile.Create(ConfigFilename);
  try
    ConfigFile.WriteString(INISection_TwilioAccount, INIKey_AccountSID, edtTwilioAccountSID.Text);
    ConfigFile.WriteString(INISection_TwilioAccount, INIKey_Password, edtTwilioAccountPassword.Text);
    ConfigFile.WriteString(INISection_TwilioAccount, INIKey_FromPhone, edtTwilioPhoneNumber.Text);
  finally
    ConfigFile.Free;
  end;
end;

end.
