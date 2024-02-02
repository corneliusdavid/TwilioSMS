program TwilioTestVCL;

uses
  Vcl.Forms,
  ufrmTwilioTestVCL in 'ufrmTwilioTestVCL.pas' {frmTwilioTestVCL};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTwilioTestVCL, frmTwilioTestVCL);
  Application.Run;
end.
