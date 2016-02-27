object FormRandomBytes: TFormRandomBytes
  Left = 326
  Top = 249
  BorderStyle = bsDialog
  Caption = 'Add Random Bytes to a File'
  ClientHeight = 162
  ClientWidth = 414
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
  object lblFile: TLabel
    Left = 24
    Top = 24
    Width = 19
    Height = 13
    Caption = 'File:'
  end
  object lblCount: TLabel
    Left = 24
    Top = 64
    Width = 55
    Height = 13
    Caption = 'Byte Count:'
  end
  object edtFile: TEdit
    Left = 56
    Top = 24
    Width = 241
    Height = 21
    TabOrder = 0
  end
  object btnBrowse: TButton
    Left = 312
    Top = 24
    Width = 75
    Height = 21
    Caption = 'Browse'
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object edtByteCount: TEdit
    Left = 96
    Top = 64
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object udCount: TUpDown
    Left = 185
    Top = 64
    Width = 15
    Height = 21
    Associate = edtByteCount
    Min = 1
    Max = 32767
    Position = 1
    TabOrder = 3
    Wrap = False
  end
  object chkRandom: TCheckBox
    Left = 248
    Top = 64
    Width = 121
    Height = 17
    Caption = 'Random Content'
    TabOrder = 4
  end
  object btnSave: TButton
    Left = 56
    Top = 104
    Width = 329
    Height = 25
    Caption = 'Add and Save'
    TabOrder = 5
    OnClick = btnSaveClick
  end
  object dlgOpen: TOpenDialog
    Left = 224
    Top = 16
  end
end
