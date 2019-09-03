object FormFile: TFormFile
  Left = 443
  Top = 235
  BorderStyle = bsDialog
  Caption = 'File to Pixels - Showing Bitmap '
  ClientHeight = 198
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblMax: TLabel
    Left = 24
    Top = 24
    Width = 30
    Height = 13
    Caption = 'lblMax'
  end
  object lblFile: TLabel
    Left = 24
    Top = 56
    Width = 19
    Height = 13
    Caption = 'File:'
  end
  object lblInfo: TLabel
    Left = 56
    Top = 80
    Width = 3
    Height = 13
  end
  object lblBlock: TLabel
    Left = 24
    Top = 116
    Width = 30
    Height = 13
    Caption = 'Block:'
  end
  object edtFile: TEdit
    Left = 56
    Top = 52
    Width = 225
    Height = 21
    TabOrder = 0
    OnChange = edtFileChange
  end
  object btnOpen: TButton
    Left = 296
    Top = 52
    Width = 75
    Height = 21
    Caption = 'Open'
    TabOrder = 1
    OnClick = btnOpenClick
  end
  object btnToPixels: TButton
    Left = 56
    Top = 160
    Width = 313
    Height = 25
    Caption = 'To Pixels      '
    TabOrder = 2
    OnClick = btnToPixelsClick
  end
  object edtBlock: TEdit
    Left = 56
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '5'
  end
  object udBlock: TUpDown
    Left = 177
    Top = 112
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
    Left = 184
    Top = 72
  end
end
