object RPFForm: TRPFForm
  Left = 269
  Top = 288
  BorderStyle = bsDialog
  Caption = 'Receive File from Ping'
  ClientHeight = 139
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblDir: TLabel
    Left = 16
    Top = 16
    Width = 77
    Height = 13
    Caption = 'Store Directory:'
  end
  object edtDir: TEdit
    Left = 104
    Top = 16
    Width = 193
    Height = 21
    TabOrder = 0
    Text = 'C:\'
  end
  object btnBrowse: TButton
    Left = 312
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object btnRecv: TButton
    Left = 16
    Top = 88
    Width = 369
    Height = 25
    Caption = 'Recv!'
    TabOrder = 2
  end
  object pbRecv: TProgressBar
    Left = 16
    Top = 56
    Width = 369
    Height = 16
    TabOrder = 3
  end
end
