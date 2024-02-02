object frmTwilioTestVCL: TfrmTwilioTestVCL
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Twilio Test VCL'
  ClientHeight = 311
  ClientWidth = 553
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 390
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    553
    311)
  PixelsPerInch = 96
  TextHeight = 16
  object lblNotFound: TLabel
    Left = 0
    Top = 295
    Width = 553
    Height = 16
    Align = alBottom
    Alignment = taCenter
    Caption = 'Could not find Twilio DLL: '
    Visible = False
    ExplicitWidth = 150
  end
  object Label1: TLabel
    Left = 42
    Top = 40
    Width = 112
    Height = 16
    Alignment = taRightJustify
    Caption = 'Twilio Account SID:'
  end
  object Label2: TLabel
    Left = 7
    Top = 70
    Width = 147
    Height = 16
    Alignment = taRightJustify
    Caption = 'Twilio Account Password:'
  end
  object Label3: TLabel
    Left = 27
    Top = 118
    Width = 127
    Height = 16
    Alignment = taRightJustify
    Caption = 'FROM Phone Number:'
  end
  object Label4: TLabel
    Left = 44
    Top = 148
    Width = 110
    Height = 16
    Alignment = taRightJustify
    Caption = 'TO Phone Number:'
  end
  object Label5: TLabel
    Left = 99
    Top = 196
    Width = 55
    Height = 16
    Alignment = taRightJustify
    Caption = 'Message:'
  end
  object edtAccountSID: TEdit
    Left = 160
    Top = 37
    Width = 378
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 160
    Top = 67
    Width = 378
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object edtFromPhone: TEdit
    Left = 160
    Top = 115
    Width = 161
    Height = 24
    TabOrder = 2
  end
  object edtToPhone: TEdit
    Left = 160
    Top = 145
    Width = 161
    Height = 24
    TabOrder = 3
  end
  object btnSendSMS: TButton
    Left = 160
    Top = 223
    Width = 121
    Height = 50
    Caption = 'Send SMS'
    TabOrder = 4
    OnClick = btnSendSMSClick
  end
  object edtMessage: TEdit
    Left = 160
    Top = 193
    Width = 378
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
  end
end
