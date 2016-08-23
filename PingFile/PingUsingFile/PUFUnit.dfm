object FormPuf: TFormPuf
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Ping Using File'
  ClientHeight = 216
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblFile: TLabel
    Left = 16
    Top = 24
    Width = 19
    Height = 13
    Caption = 'File:'
  end
  object lblInfo: TLabel
    Left = 48
    Top = 56
    Width = 3
    Height = 13
  end
  object lblPackSize: TLabel
    Left = 16
    Top = 88
    Width = 60
    Height = 13
    Caption = 'Packet Size:'
  end
  object lblIP: TLabel
    Left = 216
    Top = 88
    Width = 44
    Height = 13
    Caption = 'Send To:'
  end
  object lblDelay: TLabel
    Left = 16
    Top = 128
    Width = 30
    Height = 13
    Caption = 'Delay:'
  end
  object edtFile: TEdit
    Left = 48
    Top = 24
    Width = 297
    Height = 21
    TabOrder = 0
    OnChange = edtFileChange
  end
  object btnBrowse: TButton
    Left = 368
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object edtSize: TEdit
    Left = 96
    Top = 88
    Width = 81
    Height = 21
    TabOrder = 2
    Text = '1024'
  end
  object btnSend: TButton
    Left = 48
    Top = 168
    Width = 393
    Height = 25
    Caption = 'Send Ping Packets'
    TabOrder = 6
    OnClick = btnSendClick
  end
  object edtIP: TEdit
    Left = 280
    Top = 88
    Width = 161
    Height = 21
    TabOrder = 3
    Text = '127.0.0.1'
  end
  object edtDelay: TEdit
    Left = 96
    Top = 128
    Width = 81
    Height = 21
    TabOrder = 4
    Text = '100'
  end
  object udDelay: TUpDown
    Left = 177
    Top = 128
    Width = 15
    Height = 21
    Associate = edtDelay
    Max = 1000
    Position = 100
    TabOrder = 5
  end
  object dlgOpen: TOpenDialog
    Left = 168
    Top = 24
  end
end
