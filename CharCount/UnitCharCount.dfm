object FormCharCount: TFormCharCount
  Left = 200
  Top = 200
  Width = 820
  Height = 500
  AutoScroll = True
  Caption = #37325#23383#32479#35745
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    812
    468)
  PixelsPerInch = 96
  TextHeight = 12
  object lblInput: TLabel
    Left = 37
    Top = 16
    Width = 60
    Height = 12
    Caption = #36755#20837#35799#35789#65306
  end
  object lblResult: TLabel
    Left = 448
    Top = 16
    Width = 132
    Height = 12
    Caption = #37325#23383#32467#26524#65288#21472#35789#19981#35745#65289#65306
  end
  object pb1: TPaintBox
    Left = 8
    Top = 40
    Width = 25
    Height = 409
    OnPaint = pb1Paint
  end
  object mmoInput: TMemo
    Left = 35
    Top = 39
    Width = 360
    Height = 410
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object mmoResult: TMemo
    Left = 449
    Top = 40
    Width = 360
    Height = 409
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btnCount: TButton
    Left = 400
    Top = 200
    Width = 43
    Height = 60
    Anchors = [akLeft, akTop, akBottom]
    Caption = #32479#35745
    TabOrder = 2
    OnClick = btnCountClick
  end
end
