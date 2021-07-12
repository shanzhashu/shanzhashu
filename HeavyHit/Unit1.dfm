object FormHit: TFormHit
  Left = 327
  Top = 142
  Width = 767
  Height = 589
  Caption = 'Heavy Hit Chicken'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pbHit: TPaintBox
    Left = 0
    Top = 0
    Width = 409
    Height = 562
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnClick = pbHitClick
    OnMouseDown = pbHitMouseDown
    OnMouseMove = pbHitMouseMove
    OnMouseUp = pbHitMouseUp
    OnPaint = pbHitPaint
  end
end
