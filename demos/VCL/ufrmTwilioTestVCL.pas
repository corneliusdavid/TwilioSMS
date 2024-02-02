unit ufrmTwilioTestVCL;

{.$DEFINE UseCorneliusComponents}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  {$IFDEF UseCorneliusComponents} LayoutSaver, {$ENDIF}
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;


type
  TTwilioSMSSendFunc = function (const AccountSID, Password, FromPhone, ToPhone, Msg: string): string; stdcall;

  TfrmTwilioTestVCL = class(TForm)
    lblNotFound: TLabel;
    edtAccountSID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPassword: TEdit;
    Label3: TLabel;
    edtFromPhone: TEdit;
    Label4: TLabel;
    edtToPhone: TEdit;
    Label5: TLabel;
    btnSendSMS: TButton;
    edtMessage: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSendSMSClick(Sender: TObject);
  private
    {$IFDEF UseCorneliusComponents}
    ccRegistryLayoutSaver: TccRegistryLayoutSaver;
    {$ENDIF}
    FTwilioLibHandle: HModule;
    FSendSMS: TTwilioSMSSendFunc;
    function CheckFields: Boolean;
    procedure SendMessage;
  end;

var
  frmTwilioTestVCL: TfrmTwilioTestVCL;

implementation

{$R *.dfm}


procedure TfrmTwilioTestVCL.btnSendSMSClick(Sender: TObject);
begin
  if (FTwilioLibHandle <> 0) and CheckFields then
    SendMessage;
end;

function TfrmTwilioTestVCL.CheckFields: Boolean;
begin
  Result := (Length(edtAccountSID.Text) > 0) and
            (Length(edtPassword.Text) > 0) and
            (Length(edtFromPhone.Text) > 0) and
            (Length(edtToPhone.Text) > 0) and
            (Length(edtMessage.Text) > 0);
end;

procedure TfrmTwilioTestVCL.FormCreate(Sender: TObject);
const
  LibName = 'TwilioSMS.dll';
begin
  FTwilioLibHandle := LoadLibrary(LibName);

  if FTwilioLibHandle = 0 then begin
    lblNotFound.Caption := lblNotFound.Caption + LibName;
    lblNotFound.Visible := True;
    btnSendSMS.Enabled := False;
  end else
    @FSendSMS := GetProcAddress(FTwilioLibHandle, 'SendTwilioSMS');

  {$IFDEF UseCorneliusComponents}
  ccRegistryLayoutSaver := TccRegistryLayoutSaver.Create(self);
  edtAccountSID.Text := ccRegistryLayoutSaver.RestoreStrValue('AcctSID');
  edtPassword.Text   := ccRegistryLayoutSaver.RestoreStrValue('PW');
  edtFromPhone.Text  := ccRegistryLayoutSaver.RestoreStrValue('FromPhone');
  edtToPhone.Text    := ccRegistryLayoutSaver.RestoreStrValue('ToPhone');
  {$ENDIF}
end;

procedure TfrmTwilioTestVCL.FormDestroy(Sender: TObject);
begin
  {$IFDEF UseCorneliusComponents}
  ccRegistryLayoutSaver.SaveStrValue('AcctSID', edtAccountSID.Text);
  ccRegistryLayoutSaver.SaveStrValue('PW', edtPassword.Text);
  ccRegistryLayoutSaver.SaveStrValue('FromPhone', edtFromPhone.Text);
  ccRegistryLayoutSaver.SaveStrValue('ToPhone', edtToPhone.Text);
  {$ENDIF}

  FreeLibrary(FTwilioLibHandle);
end;

procedure TfrmTwilioTestVCL.SendMessage;
var
  response: string;
begin
  response := FSendSMS(edtAccountSID.Text, edtPassword.Text, edtFromPhone.Text, edtToPhone.Text, edtMessage.Text);
  ShowMessage('Response: ' + response);
end;

end.
