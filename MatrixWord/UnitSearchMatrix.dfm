object FormMatrixWord: TFormMatrixWord
  Left = 201
  Top = 98
  Width = 1411
  Height = 871
  Caption = 'Search Word in Matrix'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblSearch: TLabel
    Left = 992
    Top = 32
    Width = 41
    Height = 13
    Caption = 'Search:'
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 16
    Width = 957
    Height = 795
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultColWidth = 16
    DefaultRowHeight = 16
    FixedCols = 0
    FixedRows = 0
    TabOrder = 0
  end
  object edtSearch: TEdit
    Left = 1040
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'CARBON'
  end
  object btnSearch: TButton
    Left = 1176
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 2
    OnClick = btnSearchClick
  end
  object btnLoad: TButton
    Left = 1040
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 3
    OnClick = btnLoadClick
  end
  object OpenDialog1: TOpenDialog
    Left = 936
    Top = 144
  end
end
