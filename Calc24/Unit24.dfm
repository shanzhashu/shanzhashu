object FormCalc: TFormCalc
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Calculate 24'
  ClientHeight = 453
  ClientWidth = 670
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
  object Bevel1: TBevel
    Left = 312
    Top = 24
    Width = 17
    Height = 401
    Shape = bsLeftLine
  end
  object edt1: TEdit
    Left = 24
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 0
    Text = '1'
  end
  object edt2: TEdit
    Left = 96
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 1
    Text = '2'
  end
  object edt3: TEdit
    Left = 160
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 2
    Text = '3'
  end
  object edt4: TEdit
    Left = 224
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 3
    Text = '4'
  end
  object btnCalc: TButton
    Left = 24
    Top = 56
    Width = 257
    Height = 25
    Caption = 'Calculate 24'
    TabOrder = 4
    OnClick = btnCalcClick
  end
  object mmoResult: TMemo
    Left = 24
    Top = 96
    Width = 257
    Height = 329
    ReadOnly = True
    TabOrder = 5
  end
  object mmoList: TMemo
    Left = 344
    Top = 64
    Width = 297
    Height = 361
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object btnList: TButton
    Left = 344
    Top = 24
    Width = 249
    Height = 25
    Caption = 'Calculate 24 for All'
    TabOrder = 7
    OnClick = btnListClick
  end
  object btnSave: TBitBtn
    Left = 608
    Top = 24
    Width = 35
    Height = 25
    Hint = 'Save'
    Default = True
    TabOrder = 8
    OnClick = btnSaveClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object dlgSave: TSaveDialog
    FileName = '24.txt'
    Left = 448
    Top = 104
  end
end
