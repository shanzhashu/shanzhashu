object FormPixel: TFormPixel
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Open 24Bit BMP'
  ClientHeight = 210
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblFile: TLabel
    Left = 16
    Top = 32
    Width = 45
    Height = 13
    Caption = 'BMP File:'
  end
  object lblInfo: TLabel
    Left = 72
    Top = 52
    Width = 3
    Height = 13
  end
  object lblBlock: TLabel
    Left = 40
    Top = 92
    Width = 30
    Height = 13
    Caption = 'Block:'
  end
  object edtFile: TEdit
    Left = 72
    Top = 28
    Width = 233
    Height = 21
    TabOrder = 0
    OnChange = edtFileChange
  end
  object btnOpen: TButton
    Left = 320
    Top = 28
    Width = 75
    Height = 21
    Caption = 'Open'
    TabOrder = 1
    OnClick = btnOpenClick
  end
  object btnExtract: TButton
    Left = 72
    Top = 136
    Width = 321
    Height = 25
    Caption = 'Extract File From BMP'
    TabOrder = 2
    OnClick = btnExtractClick
  end
  object edtBlock: TEdit
    Left = 72
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '5'
  end
  object udBlock: TUpDown
    Left = 193
    Top = 88
    Width = 15
    Height = 21
    Associate = edtBlock
    Min = 1
    Max = 7
    Position = 5
    TabOrder = 4
    OnChangingEx = udBlockChangingEx
  end
  object dlgOpen: TOpenDialog
    Left = 208
    Top = 72
  end
  object dlgSave: TSaveDialog
    Left = 264
    Top = 112
  end
end
