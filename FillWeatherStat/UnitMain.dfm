object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #27668#35937#26680#26597#25253#21578#19968#38190#24335#29983#25104#31995#32479' 1.0.9'
  ClientHeight = 863
  ClientWidth = 612
  Color = clBtnFace
  Constraints.MaxWidth = 620
  Constraints.MinHeight = 890
  Constraints.MinWidth = 620
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    612
    863)
  PixelsPerInch = 96
  TextHeight = 12
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 613
    Height = 828
    ActivePage = ts1
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabPosition = tpBottom
    OnChange = pgcMainChange
    object ts1: TTabSheet
      Caption = #27668#28201
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 605
        Height = 790
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          605
          790)
        object fcpSheet1: TFlexCelPreviewer
          Left = 0
          Top = 0
          Width = 603
          Height = 788
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 798
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl1BeiHeCha: TLabel
            Left = 331
            Top = 176
            Width = 72
            Height = 12
            Caption = #34987#26680#26597#22120#20855#65306
            Transparent = True
          end
          object edt1QiWen: TEdit
            Left = 228
            Top = 125
            Width = 35
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            Text = '23.9'
            OnChange = UpdateSheet1
          end
          object edt1ShiDu: TEdit
            Left = 325
            Top = 125
            Width = 21
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 2
            Text = '42'
            OnChange = UpdateSheet1
          end
          object edt1FengSu: TEdit
            Left = 437
            Top = 125
            Width = 23
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            Text = '2.0'
            OnChange = UpdateSheet1
          end
          object edt1KaiShiShiJian: TMaskEdit
            Left = 201
            Top = 148
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet1
          end
          object edt1JieShuShiJian: TMaskEdit
            Left = 459
            Top = 148
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet1
          end
          object cbb1HeGe: TComboBox
            Left = 215
            Top = 644
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 23
            Text = #21512#26684
            OnChange = UpdateSheet1
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object edt1JiaoZhunShiJian: TEdit
            Left = 418
            Top = 712
            Width = 121
            Height = 20
            TabOrder = 28
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet1
          end
          object cbb1BeiHeCha: TComboBox
            Left = 398
            Top = 171
            Width = 115
            Height = 20
            TabOrder = 6
            OnChange = UpdateSheet1
          end
          object cbb1WaiGuanHeGe: TComboBox
            Left = 124
            Top = 422
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = #21512#26684
            OnChange = UpdateSheet1
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb1FuHeYaoQiu: TComboBox
            Left = 215
            Top = 690
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 25
            Text = #26159
            OnChange = UpdateSheet1
            Items.Strings = (
              #26159
              #21542)
          end
          object cbb1JiaoZhun: TComboBox
            Left = 95
            Top = 710
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 26
            OnChange = UpdateSheet1
          end
          object cbb1HeYan: TComboBox
            Left = 251
            Top = 710
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 27
            OnChange = UpdateSheet1
          end
          object cbb1HeChaYiJu: TComboBox
            Left = 215
            Top = 666
            Width = 323
            Height = 20
            Style = csDropDownList
            TabOrder = 24
            OnChange = UpdateSheet1
          end
          object edt1JiLuBianHao: TEdit
            Left = 392
            Top = 101
            Width = 150
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(T)2303150101'
          end
          object edt1BeiHeCha1: TEdit
            Left = 416
            Top = 495
            Width = 70
            Height = 20
            TabOrder = 11
            Text = '-10.113'
            OnChange = UpdateSheet1
          end
          object edt1BeiHeCha2: TEdit
            Left = 416
            Top = 551
            Width = 70
            Height = 20
            TabOrder = 16
            Text = '-0.089'
            OnChange = UpdateSheet1
          end
          object edt1BeiHeCha3: TEdit
            Left = 416
            Top = 605
            Width = 70
            Height = 20
            TabOrder = 20
            Text = '29.983'
            OnChange = UpdateSheet1
          end
          object edt1XiuZhengZhi1: TEdit
            Left = 216
            Top = 495
            Width = 100
            Height = 20
            TabOrder = 10
            Text = '-0.003'
            OnChange = UpdateSheet1
          end
          object edt1XiuZhengZhi2: TEdit
            Left = 216
            Top = 551
            Width = 100
            Height = 20
            TabOrder = 15
            Text = '-0.005'
            OnChange = UpdateSheet1
          end
          object edt1XiuZhengZhi3: TEdit
            Left = 216
            Top = 605
            Width = 100
            Height = 20
            TabOrder = 19
            Text = '-0.013'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi1: TEdit
            Left = 124
            Top = 477
            Width = 90
            Height = 20
            TabOrder = 8
            Text = '-9.992'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi2: TEdit
            Left = 124
            Top = 495
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '-9.989'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi3: TEdit
            Left = 124
            Top = 513
            Width = 90
            Height = 20
            TabOrder = 12
            Text = '-9.996'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi4: TEdit
            Left = 124
            Top = 532
            Width = 90
            Height = 20
            TabOrder = 13
            Text = '0.024'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi5: TEdit
            Left = 124
            Top = 551
            Width = 90
            Height = 20
            TabOrder = 14
            Text = '0.035'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi6: TEdit
            Left = 124
            Top = 570
            Width = 90
            Height = 20
            TabOrder = 17
            Text = '0.031'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi7: TEdit
            Left = 124
            Top = 589
            Width = 90
            Height = 20
            TabOrder = 18
            Text = '30.102'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi8: TEdit
            Left = 124
            Top = 607
            Width = 90
            Height = 20
            TabOrder = 21
            Text = '30.095'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi9: TEdit
            Left = 124
            Top = 625
            Width = 90
            Height = 20
            TabOrder = 22
            Text = '30.092'
            OnChange = UpdateSheet1
          end
        end
      end
    end
    object ts2: TTabSheet
      Caption = #28287#24230
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 605
        Height = 790
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          605
          790)
        object fcpSheet2: TFlexCelPreviewer
          Left = 0
          Top = 1
          Width = 603
          Height = 788
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 798
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl2BeiHeCha: TLabel
            Left = 339
            Top = 178
            Width = 72
            Height = 12
            Caption = #34987#26680#26597#22120#20855#65306
            Transparent = True
          end
          object edt2JiLuBianHao: TEdit
            Left = 396
            Top = 97
            Width = 156
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(TH)2303150101'
            OnChange = UpdateSheet2
          end
          object edt2QiWen: TEdit
            Left = 242
            Top = 121
            Width = 35
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            Text = '23.9'
            OnChange = UpdateSheet2
          end
          object edt2ShiDu: TEdit
            Left = 339
            Top = 121
            Width = 21
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 2
            Text = '42'
            OnChange = UpdateSheet2
          end
          object edt2FengSu: TEdit
            Left = 450
            Top = 121
            Width = 23
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            Text = '2.0'
            OnChange = UpdateSheet2
          end
          object edt2KaiShiShiJian: TMaskEdit
            Left = 210
            Top = 147
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet2
          end
          object edt2JieShuShiJian: TMaskEdit
            Left = 460
            Top = 147
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 5
            Text = '15:50'
            OnChange = UpdateSheet2
          end
          object cbb2BeiHeCha: TComboBox
            Left = 404
            Top = 173
            Width = 115
            Height = 20
            TabOrder = 6
            OnChange = UpdateSheet2
          end
          object cbb2WaiGuanHeGe: TComboBox
            Left = 139
            Top = 412
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = #21512#26684
            OnChange = UpdateSheet2
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb2HeGe: TComboBox
            Left = 139
            Top = 610
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 18
            Text = #21512#26684
            OnChange = UpdateSheet2
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb2HeChaYiJu: TComboBox
            Left = 139
            Top = 636
            Width = 413
            Height = 20
            Style = csDropDownList
            TabOrder = 19
            OnChange = UpdateSheet2
          end
          object cbb2FuHeYaoQiu: TComboBox
            Left = 139
            Top = 664
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 20
            Text = #26159
            OnChange = UpdateSheet2
            Items.Strings = (
              #26159
              #21542)
          end
          object cbb2JiaoZhun: TComboBox
            Left = 104
            Top = 692
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 21
            OnChange = UpdateSheet2
          end
          object cbb2HeYan: TComboBox
            Left = 260
            Top = 692
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 22
            OnChange = UpdateSheet2
          end
          object edt2JiaoZhunShiJian: TEdit
            Left = 412
            Top = 694
            Width = 140
            Height = 20
            TabOrder = 23
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi1: TEdit
            Left = 139
            Top = 473
            Width = 90
            Height = 20
            TabOrder = 8
            Text = '86.6'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi2: TEdit
            Left = 139
            Top = 496
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '86.8'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi3: TEdit
            Left = 139
            Top = 519
            Width = 90
            Height = 20
            TabOrder = 12
            Text = '87.0'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi4: TEdit
            Left = 139
            Top = 542
            Width = 90
            Height = 20
            TabOrder = 13
            Text = '33.0'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi5: TEdit
            Left = 139
            Top = 563
            Width = 90
            Height = 20
            TabOrder = 16
            Text = '33.1'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi6: TEdit
            Left = 139
            Top = 584
            Width = 90
            Height = 20
            TabOrder = 17
            Text = '33.2'
            OnChange = UpdateSheet2
          end
          object edt2XiuZhengZhi1: TEdit
            Left = 231
            Top = 496
            Width = 100
            Height = 20
            TabOrder = 10
            Text = '1.2'
            OnChange = UpdateSheet2
          end
          object edt2XiuZhengZhi2: TEdit
            Left = 231
            Top = 560
            Width = 100
            Height = 20
            TabOrder = 14
            Text = '-1.7'
            OnChange = UpdateSheet2
          end
          object edt2BeiHeCha1: TEdit
            Left = 419
            Top = 496
            Width = 70
            Height = 20
            TabOrder = 11
            Text = '92.2'
            OnChange = UpdateSheet2
          end
          object edt2BeiHeCha2: TEdit
            Left = 419
            Top = 560
            Width = 70
            Height = 20
            TabOrder = 15
            Text = '34.3'
            OnChange = UpdateSheet2
          end
        end
      end
    end
    object ts3: TTabSheet
      Caption = #39118#21521
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object ScrollBox3: TScrollBox
        Left = 0
        Top = 0
        Width = 605
        Height = 790
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          605
          790)
        object fcpSheet3: TFlexCelPreviewer
          Left = 0
          Top = 0
          Width = 603
          Height = 788
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 798
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl3BeiHeCha: TLabel
            Left = 343
            Top = 192
            Width = 72
            Height = 12
            Caption = #34987#26680#26597#22120#20855#65306
            Transparent = True
          end
          object cbb3FuHeYaoQiu: TComboBox
            Left = 234
            Top = 640
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 13
            Text = #26159
            OnChange = UpdateSheet3
            Items.Strings = (
              #26159
              #21542)
          end
          object cbb3HeChaYiJu: TComboBox
            Left = 234
            Top = 616
            Width = 318
            Height = 20
            Style = csDropDownList
            TabOrder = 12
            OnChange = UpdateSheet3
          end
          object cbb3HeGe: TComboBox
            Left = 234
            Top = 592
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 11
            Text = #21512#26684
            OnChange = UpdateSheet3
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb3WaiGuanHeGe: TComboBox
            Left = 123
            Top = 416
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = #21512#26684
            OnChange = UpdateSheet3
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb3BeiHeCha: TComboBox
            Left = 408
            Top = 189
            Width = 115
            Height = 20
            TabOrder = 6
            OnChange = UpdateSheet3
          end
          object edt3KaiShiShiJian: TMaskEdit
            Left = 209
            Top = 164
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet3
          end
          object edt3QiWen: TEdit
            Left = 234
            Top = 137
            Width = 35
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            Text = '23.9'
            OnChange = UpdateSheet3
          end
          object edt3ShiDu: TEdit
            Left = 331
            Top = 137
            Width = 21
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 2
            Text = '42'
            OnChange = UpdateSheet3
          end
          object edt3FengSu: TEdit
            Left = 440
            Top = 137
            Width = 23
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            Text = '2.0'
            OnChange = UpdateSheet3
          end
          object edt3JieShuShiJian: TMaskEdit
            Left = 467
            Top = 164
            Width = 46
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet3
          end
          object edt3JiLuBianHao: TEdit
            Left = 396
            Top = 111
            Width = 156
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(VX)2303150101'
            OnChange = UpdateSheet3
          end
          object cbb3JiaoZhun: TComboBox
            Left = 98
            Top = 664
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 14
            OnChange = UpdateSheet3
          end
          object edt3JiaoZhunShiJian: TEdit
            Left = 431
            Top = 664
            Width = 121
            Height = 20
            TabOrder = 16
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet3
          end
          object cbb3HeYan: TComboBox
            Left = 270
            Top = 664
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 15
            OnChange = UpdateSheet3
          end
          object edt3BeiHeCha1: TEdit
            Left = 125
            Top = 482
            Width = 106
            Height = 20
            TabOrder = 8
            Text = '0'
            OnChange = UpdateSheet3
          end
          object edt3BeiHeCha2: TEdit
            Left = 125
            Top = 520
            Width = 106
            Height = 20
            TabOrder = 9
            Text = '120'
            OnChange = UpdateSheet3
          end
          object edt3BeiHeCha3: TEdit
            Left = 125
            Top = 560
            Width = 106
            Height = 20
            TabOrder = 10
            Text = '241'
            OnChange = UpdateSheet3
          end
        end
      end
    end
    object ts4: TTabSheet
      Caption = #39118#36895
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object ScrollBox4: TScrollBox
        Left = 0
        Top = 0
        Width = 605
        Height = 790
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          605
          790)
        object fcpSheet4: TFlexCelPreviewer
          Left = 0
          Top = -1
          Width = 603
          Height = 788
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 798
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl4BeiHeCha: TLabel
            Left = 341
            Top = 188
            Width = 72
            Height = 12
            Caption = #34987#26680#26597#22120#20855#65306
            Transparent = True
          end
          object edt4JiLuBianHao: TEdit
            Left = 388
            Top = 107
            Width = 156
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(VS)2303150101'
            OnChange = UpdateSheet4
          end
          object edt4QiWen: TEdit
            Left = 236
            Top = 133
            Width = 35
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            Text = '23.9'
            OnChange = UpdateSheet4
          end
          object edt4ShiDu: TEdit
            Left = 333
            Top = 133
            Width = 21
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 2
            Text = '42'
            OnChange = UpdateSheet4
          end
          object edt4FengSu: TEdit
            Left = 442
            Top = 133
            Width = 23
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            Text = '2.0'
            OnChange = UpdateSheet4
          end
          object edt4JieShuShiJian: TMaskEdit
            Left = 468
            Top = 159
            Width = 46
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet4
          end
          object cbb4BeiHeCha: TComboBox
            Left = 406
            Top = 185
            Width = 115
            Height = 20
            TabOrder = 6
            OnChange = UpdateSheet4
          end
          object cbb4WaiGuanHeGe: TComboBox
            Left = 139
            Top = 410
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = #21512#26684
            OnChange = UpdateSheet4
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb4HeGe: TComboBox
            Left = 232
            Top = 609
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 23
            Text = #21512#26684
            OnChange = UpdateSheet4
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb4HeChaYiJu: TComboBox
            Left = 232
            Top = 634
            Width = 312
            Height = 20
            Style = csDropDownList
            TabOrder = 24
            OnChange = UpdateSheet4
          end
          object cbb4FuHeYaoQiu: TComboBox
            Left = 232
            Top = 659
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 25
            Text = #26159
            OnChange = UpdateSheet4
            Items.Strings = (
              #26159
              #21542)
          end
          object edt4JiaoZhunShiJian: TEdit
            Left = 426
            Top = 682
            Width = 118
            Height = 20
            TabOrder = 28
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet4
          end
          object cbb4JiaoZhun: TComboBox
            Left = 106
            Top = 682
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 26
            OnChange = UpdateSheet4
          end
          object cbb4HeYan: TComboBox
            Left = 269
            Top = 682
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 27
            OnChange = UpdateSheet4
          end
          object edt4KaiShiShiJian: TMaskEdit
            Left = 212
            Top = 159
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet3
          end
          object edt4BiaoZhunZhi1: TEdit
            Left = 137
            Top = 474
            Width = 90
            Height = 20
            TabOrder = 8
            Text = '2.0'
            OnChange = UpdateSheet4
          end
          object edt4BiaoZhunZhi2: TEdit
            Left = 137
            Top = 500
            Width = 90
            Height = 20
            TabOrder = 11
            Text = '5.0'
            OnChange = UpdateSheet4
          end
          object edt4BiaoZhunZhi3: TEdit
            Left = 137
            Top = 527
            Width = 90
            Height = 20
            TabOrder = 14
            Text = '10.0'
            OnChange = UpdateSheet4
          end
          object edt4BiaoZhunZhi4: TEdit
            Left = 137
            Top = 554
            Width = 90
            Height = 20
            TabOrder = 17
            Text = '20.2'
            OnChange = UpdateSheet4
          end
          object edt4BiaoZhunZhi5: TEdit
            Left = 137
            Top = 581
            Width = 90
            Height = 20
            TabOrder = 20
            Text = '40.4'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha1: TEdit
            Left = 233
            Top = 474
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '2.0'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha2: TEdit
            Left = 233
            Top = 500
            Width = 90
            Height = 20
            TabOrder = 12
            Text = '4.9'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha3: TEdit
            Left = 233
            Top = 527
            Width = 90
            Height = 20
            TabOrder = 15
            Text = '10.0'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha4: TEdit
            Left = 233
            Top = 554
            Width = 90
            Height = 20
            TabOrder = 18
            Text = '20.1'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha5: TEdit
            Left = 233
            Top = 581
            Width = 90
            Height = 20
            TabOrder = 21
            Text = '40.4'
            OnChange = UpdateSheet4
          end
          object cbb4JieGuoHeGe1: TComboBox
            Left = 426
            Top = 474
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 10
            Text = #21512#26684
            OnChange = UpdateSheet4
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb4JieGuoHeGe2: TComboBox
            Left = 426
            Top = 500
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 13
            Text = #21512#26684
            OnChange = UpdateSheet4
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb4JieGuoHeGe3: TComboBox
            Left = 426
            Top = 528
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 16
            Text = #21512#26684
            OnChange = UpdateSheet4
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb4JieGuoHeGe4: TComboBox
            Left = 426
            Top = 554
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 19
            Text = #21512#26684
            OnChange = UpdateSheet4
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb4JieGuoHeGe5: TComboBox
            Left = 426
            Top = 581
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 22
            Text = #21512#26684
            OnChange = UpdateSheet4
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
        end
      end
    end
    object ts5: TTabSheet
      Caption = #27668#21387
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object ScrollBox5: TScrollBox
        Left = 0
        Top = 0
        Width = 605
        Height = 790
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          605
          790)
        object fcpSheet5: TFlexCelPreviewer
          Left = 0
          Top = -1
          Width = 603
          Height = 788
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 798
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl5BeiHeCha: TLabel
            Left = 333
            Top = 189
            Width = 72
            Height = 12
            Caption = #34987#26680#26597#22120#20855#65306
            Transparent = True
          end
          object edt5JiLuBianHao: TEdit
            Left = 384
            Top = 109
            Width = 162
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(P)2303150101'
            OnChange = UpdateSheet5
          end
          object edt5QiWen: TEdit
            Left = 228
            Top = 135
            Width = 35
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            Text = '23.9'
            OnChange = UpdateSheet5
          end
          object edt5ShiDu: TEdit
            Left = 327
            Top = 135
            Width = 21
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 2
            Text = '42'
            OnChange = UpdateSheet5
          end
          object edt5FengSu: TEdit
            Left = 437
            Top = 135
            Width = 23
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            Text = '2.0'
            OnChange = UpdateSheet5
          end
          object edt5JieShuShiJian: TMaskEdit
            Left = 463
            Top = 160
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet5
          end
          object edt5KaiShiShiJian: TMaskEdit
            Left = 207
            Top = 160
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet5
          end
          object cbb5BeiHeCha: TComboBox
            Left = 400
            Top = 185
            Width = 115
            Height = 20
            TabOrder = 6
            OnChange = UpdateSheet5
          end
          object cbb5WaiGuanHeGe: TComboBox
            Left = 127
            Top = 392
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = #21512#26684
            OnChange = UpdateSheet5
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb5HeGe: TComboBox
            Left = 217
            Top = 620
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 23
            Text = #21512#26684
            OnChange = UpdateSheet5
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb5HeChaYiJu: TComboBox
            Left = 217
            Top = 644
            Width = 323
            Height = 20
            Style = csDropDownList
            TabOrder = 24
            OnChange = UpdateSheet5
          end
          object cbb5FuHeYaoQiu: TComboBox
            Left = 217
            Top = 670
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 25
            Text = #26159
            OnChange = UpdateSheet5
            Items.Strings = (
              #26159
              #21542)
          end
          object edt5JiaoZhunShiJian: TEdit
            Left = 412
            Top = 693
            Width = 133
            Height = 20
            TabOrder = 28
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet5
          end
          object cbb5JiaoZhun: TComboBox
            Left = 92
            Top = 693
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 26
            OnChange = UpdateSheet5
          end
          object cbb5HeYan: TComboBox
            Left = 250
            Top = 693
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 27
            OnChange = UpdateSheet5
          end
          object edt5BeiHeCha1: TEdit
            Left = 416
            Top = 472
            Width = 70
            Height = 20
            TabOrder = 11
            Text = '950.10'
            OnChange = UpdateSheet5
          end
          object edt5BeiHeCha2: TEdit
            Left = 416
            Top = 528
            Width = 70
            Height = 20
            TabOrder = 16
            Text = '1000.10'
            OnChange = UpdateSheet5
          end
          object edt5BeiHeCha3: TEdit
            Left = 416
            Top = 582
            Width = 70
            Height = 20
            TabOrder = 21
            Text = '1050.00'
            OnChange = UpdateSheet5
          end
          object edt5XiuZhengZhi1: TEdit
            Left = 217
            Top = 472
            Width = 100
            Height = 20
            TabOrder = 10
            Text = '-0.04'
            OnChange = UpdateSheet5
          end
          object edt5XiuZhengZhi2: TEdit
            Left = 217
            Top = 528
            Width = 100
            Height = 20
            TabOrder = 15
            Text = '-0.04'
            OnChange = UpdateSheet5
          end
          object edt5XiuZhengZhi3: TEdit
            Left = 217
            Top = 582
            Width = 100
            Height = 20
            TabOrder = 20
            Text = '-0.04'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi1: TEdit
            Left = 125
            Top = 449
            Width = 90
            Height = 20
            TabOrder = 8
            Text = '950'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi2: TEdit
            Left = 125
            Top = 468
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '950'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi3: TEdit
            Left = 125
            Top = 487
            Width = 90
            Height = 20
            TabOrder = 12
            Text = '950'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi6: TEdit
            Left = 125
            Top = 544
            Width = 90
            Height = 20
            TabOrder = 17
            Text = '1000'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi5: TEdit
            Left = 125
            Top = 525
            Width = 90
            Height = 20
            TabOrder = 14
            Text = '1000'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi4: TEdit
            Left = 125
            Top = 506
            Width = 90
            Height = 20
            TabOrder = 13
            Text = '1000'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi7: TEdit
            Left = 125
            Top = 563
            Width = 90
            Height = 20
            TabOrder = 18
            Text = '1050'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi8: TEdit
            Left = 125
            Top = 582
            Width = 90
            Height = 20
            TabOrder = 19
            Text = '1050'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi9: TEdit
            Left = 125
            Top = 601
            Width = 90
            Height = 20
            TabOrder = 22
            Text = '1050'
            OnChange = UpdateSheet5
          end
        end
      end
    end
    object ts6: TTabSheet
      Caption = #38632#37327
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object ScrollBox6: TScrollBox
        Left = 0
        Top = 0
        Width = 605
        Height = 790
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          605
          790)
        object fcpSheet6: TFlexCelPreviewer
          Left = 0
          Top = -1
          Width = 603
          Height = 788
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 798
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl6BeiHeCha: TLabel
            Left = 333
            Top = 192
            Width = 72
            Height = 12
            Caption = #34987#26680#26597#22120#20855#65306
            Transparent = True
          end
          object edt6JiLuBianHao: TEdit
            Left = 396
            Top = 109
            Width = 148
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(R)2303150101'
            OnChange = UpdateSheet6
          end
          object edt6FengSu: TEdit
            Left = 438
            Top = 137
            Width = 23
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            Text = '2.0'
            OnChange = UpdateSheet6
          end
          object edt6ShiDu: TEdit
            Left = 327
            Top = 137
            Width = 21
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 2
            Text = '42'
            OnChange = UpdateSheet6
          end
          object edt6QiWen: TEdit
            Left = 230
            Top = 137
            Width = 35
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            Text = '23.9'
            OnChange = UpdateSheet6
          end
          object edt6KaiShiShiJian: TMaskEdit
            Left = 207
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet6
          end
          object edt6JieShuShiJian: TMaskEdit
            Left = 463
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet6
          end
          object cbb6BeiHeCha: TComboBox
            Left = 400
            Top = 188
            Width = 115
            Height = 20
            TabOrder = 6
            OnChange = UpdateSheet6
          end
          object cbb6WaiGuanHeGe: TComboBox
            Left = 125
            Top = 430
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = #21512#26684
            OnChange = UpdateSheet6
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb6HeGe: TComboBox
            Left = 216
            Top = 602
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 14
            Text = #21512#26684
            OnChange = UpdateSheet6
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb6HeChaYiJu: TComboBox
            Left = 216
            Top = 628
            Width = 323
            Height = 20
            Style = csDropDownList
            TabOrder = 15
            OnChange = UpdateSheet6
          end
          object cbb6FuHeYaoQiu: TComboBox
            Left = 216
            Top = 654
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 16
            Text = #26159
            OnChange = UpdateSheet6
            Items.Strings = (
              #26159
              #21542)
          end
          object cbb6HeYan: TComboBox
            Left = 256
            Top = 676
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 18
            OnChange = UpdateSheet6
          end
          object cbb6JiaoZhun: TComboBox
            Left = 116
            Top = 676
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 17
            OnChange = UpdateSheet6
          end
          object edt6JiaoZhunShiJian: TEdit
            Left = 412
            Top = 676
            Width = 132
            Height = 20
            TabOrder = 19
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi1: TEdit
            Left = 321
            Top = 489
            Width = 90
            Height = 20
            TabOrder = 8
            Text = '10.2'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi2: TEdit
            Left = 321
            Top = 508
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '10.3'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi3: TEdit
            Left = 321
            Top = 527
            Width = 90
            Height = 20
            TabOrder = 10
            Text = '10.2'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi4: TEdit
            Left = 321
            Top = 546
            Width = 90
            Height = 20
            TabOrder = 11
            Text = '10.3'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi5: TEdit
            Left = 321
            Top = 564
            Width = 90
            Height = 20
            TabOrder = 12
            Text = '10.3'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi6: TEdit
            Left = 321
            Top = 581
            Width = 90
            Height = 20
            TabOrder = 13
            Text = '10.3'
            OnChange = UpdateSheet6
          end
        end
      end
    end
    object ts7: TTabSheet
      Caption = #36215#21160#39118
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object ScrollBox7: TScrollBox
        Left = 0
        Top = 0
        Width = 605
        Height = 790
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          605
          790)
        object fcpSheet7: TFlexCelPreviewer
          Left = 0
          Top = 0
          Width = 603
          Height = 788
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 798
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl7BeiHeCha: TLabel
            Left = 337
            Top = 192
            Width = 72
            Height = 12
            Caption = #34987#26680#26597#22120#20855#65306
            Transparent = True
          end
          object edt7JiLuBianHao: TEdit
            Left = 396
            Top = 111
            Width = 154
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(VS)2303150201'
            OnChange = UpdateSheet7
          end
          object edt7QiWen: TEdit
            Left = 232
            Top = 138
            Width = 35
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            Text = '23.9'
            OnChange = UpdateSheet7
          end
          object edt7ShiDu: TEdit
            Left = 329
            Top = 138
            Width = 21
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 2
            Text = '42'
            OnChange = UpdateSheet7
          end
          object edt7FengSu: TEdit
            Left = 440
            Top = 138
            Width = 23
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            Text = '2.0'
            OnChange = UpdateSheet7
          end
          object edt7JieShuShiJian: TMaskEdit
            Left = 462
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet7
          end
          object edt7KaiShiShiJian: TMaskEdit
            Left = 204
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet7
          end
          object cbb7BeiHeCha: TComboBox
            Left = 403
            Top = 189
            Width = 115
            Height = 20
            TabOrder = 6
            OnChange = UpdateSheet7
          end
          object cbb7WaiGuanHeGe: TComboBox
            Left = 125
            Top = 430
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = #21512#26684
            OnChange = UpdateSheet7
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb7HeChaYiJu: TComboBox
            Left = 214
            Top = 622
            Width = 323
            Height = 20
            Style = csDropDownList
            TabOrder = 13
            OnChange = UpdateSheet7
          end
          object cbb7FuHeYaoQiu: TComboBox
            Left = 214
            Top = 647
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 14
            Text = #26159
            OnChange = UpdateSheet7
            Items.Strings = (
              #26159
              #21542)
          end
          object edt7JiaoZhunShiJian: TEdit
            Left = 418
            Top = 670
            Width = 132
            Height = 20
            TabOrder = 17
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet7
          end
          object cbb7JiaoZhun: TComboBox
            Left = 124
            Top = 670
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 15
            OnChange = UpdateSheet7
          end
          object cbb7HeYan: TComboBox
            Left = 256
            Top = 670
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 16
            OnChange = UpdateSheet7
          end
          object edt7BiaoZhunZhi1: TEdit
            Left = 124
            Top = 497
            Width = 192
            Height = 20
            TabOrder = 8
            OnChange = UpdateSheet7
          end
          object edt7BiaoZhunZhi2: TEdit
            Left = 125
            Top = 535
            Width = 192
            Height = 20
            TabOrder = 9
            OnChange = UpdateSheet7
          end
          object edt7BiaoZhunZhi3: TEdit
            Left = 124
            Top = 569
            Width = 192
            Height = 20
            TabOrder = 11
            OnChange = UpdateSheet7
          end
          object edt7HeChaJieGuo: TEdit
            Left = 345
            Top = 535
            Width = 192
            Height = 20
            TabOrder = 10
            Text = '0.0'
            OnChange = UpdateSheet7
          end
          object edt7ZuiDaYunXuZhi: TEdit
            Left = 214
            Top = 596
            Width = 323
            Height = 20
            TabOrder = 12
            OnChange = UpdateSheet7
          end
        end
      end
    end
  end
  object pnlMain: TPanel
    Left = 384
    Top = 829
    Width = 225
    Height = 36
    Anchors = [akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object btnPDF: TSpeedButton
      Left = 72
      Top = 0
      Width = 35
      Height = 34
      Hint = #36755#20986#25104'PDF'#25991#20214
      Flat = True
      Glyph.Data = {
        92040000424D9204000000000000920000002800000020000000200000000100
        08000000000000040000120B0000120B0000170000001700000000000000FFFF
        FF006969FF006A6AFF007676FF007C7CFF008E8EFF008F8FFF009292FF00A1A1
        FF00A2A2FF00A8A8FF00A9A9FF00B4B4FF00C3C3FF00D9D9FF00DADAFF00DCDC
        FF00E5E5FF00E9E9FF00F7F7FF00FEFEFF00FFFFFF0001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010403
        0303030303030303030303030303030303140101010101010101010102020202
        0202020202020202020202020202020202020201010101010101010102021315
        1515151515151515151515151515151515020201010101010101010102020101
        01010101010101010101010101010101010F0207010101010101010102020101
        01010101010101010101010101010101010F0207010101010101010102020101
        01010101010101010101010101010101010F0207010101010101010102020101
        01010101010101010101010101010101010F0207010101010101010102020101
        01010101010101010101010101010101010F0207010101011002020202020202
        02020202020202020202050101010101010F0207010101010202020202020202
        02020202020202020202021201010101010F0207010101010202020202020202
        02020202020202020202020303030301010F0207010101010202020202020202
        02020202020202020202020202020209010F0207010101010202020202020202
        02020202020202020202020701010101010F0207010101010202020102020202
        01010101020201020202020701010101010F0207010101010202020102020202
        01060201080201020202020202020201010F0207010101010202020101011102
        0106020101020101010202020202020B010F0207010101010202020102020102
        01060201150201020202020701010101010F0207010101010202020102010102
        01060101020201060606020701010101010F0207010101010202020101010202
        01010102020201010106020202020201010F0207010101010202020202020202
        0202020202020202020202020202020B010F0207010101010202020202020202
        02020202020202020202020C01010101010F0207010101010202020202020202
        02020202020202020202020101010101010F0207010101010101010102020101
        01010101010101010101010101010101010F0207010101010101010102020101
        01010101010101010101010101010101010F0207010101010101010102020101
        01010101010101010101010101010101010F0207010101010101010102020101
        01010101010101010101010101010101010D020A010101010101010102020202
        020202020202020202020202020202020202020101010101010101010E020202
        0202020202020202020202020202020202020501010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPDFClick
    end
    object btnToggleVisible: TSpeedButton
      Left = 109
      Top = 0
      Width = 35
      Height = 34
      Hint = #20999#25442#26174#31034#27169#24335
      Flat = True
      Glyph.Data = {
        4E060000424D4E060000000000004E0200002800000020000000200000000100
        08000000000000040000120B0000120B0000860000008600000000000000FFFF
        FF00FAF6F600F9F5F500FBF8F800FAF7F700FBF9F900FDFCFC00CB928C00CFAE
        AA00F3EAE900F1E8E70089392D00AB736B00B17C7400B27F7800B7878000B889
        8200B9898300B98A8300C29A9400C7A19C00DFCAC700E2CECB00E0CCC900E3D3
        D100EADCDA00F4ECEB00F3EBEA00F2EAE9007A221300792213007B2314007B24
        15007C2516007C2517007D2618007D2719007E291A007F2B1C00802C1D00812D
        1F00822F2100822F220082302200833123008432250085352700863628008737
        290088392C008A3C2F008C3F320090463A0091493C0091493D00934C3F00944C
        4000944D4100954E4200965044009651450097524600975347009A584C009B59
        4D009B594E009C5A4F009C5B50009D5D52009F5F5400A0605600A0615600A161
        5700A1625700A3655A00A4675C00A5695F00A76C6200A66C6200A86E6500A86F
        6500AB716800A8706700AC756C00AD776E00AE797000AB797000B2807700B482
        7900B4837A00B8888000B98A8200B98B8300BA8D8500C7A29C00CBA8A200CAA7
        A100CCABA500D1B3AE00D4B7B200DCC4C000DAC2BE00DCC5C100EFE4E200EEE3
        E100F7F1F000F6F0EF00894234009B584B009C5C5000A56A5F00A66D6200B484
        7B00C9A49D00C6A19A00D3B6B000D6BBB600D5BAB500D9C1BC00DBC4BF00E2CF
        CB00E1CECA00E8DAD700F8F3F200F8F4F300C9A69D00F4EDEB00EDE3E000F5EF
        ED00F4EEEC00FDFCFB00FCFBFA00FFFFFF000101010101010101011A144D3D34
        312E2F3338495E1784010101010101010101010101010101847543231E1E1E1E
        1E1E1E1E1E1E1E1E375F7C01010101010101010101010116371E1E1E1E1E1E1E
        1E1E1E1E1E1E1E1E1E1E2F61010101010101631C010173241E1E1E1E1E1E2325
        1E1E1E23251E1E1E1E1E1E1E0D0401837479273E820F1E1E1E1E1E2B54766856
        1E1E1E3A68655C331E1E1E1E1E416B581E102C1E31221E1E1E27130A0101015A
        1E1E1E3E0101010360331E1E1E1E322023112C1E1E1E1E1E3F7B01010101015A
        1E1E1E3E01010101016A511E1E1E1E1E23122C1E1E1E1E6D040101010101015A
        1E1E1E3E01010101010101591E1E1E1E23122C1E1E1E1E6E7D0101010101015A
        1E1E1E3E010101010101015B1E1E1E1E23122C1E1E1E1E1E388201010101015A
        1E1E1E3E010101010101561E1E1E1E1E23114F3B3F3F3F3F361901010101015A
        1E1E1E3E010101010105473A3F3F3F3C4409010101010101010101010101015A
        1E1E1E3E0101010101010101010101010101010101010101010101010101015A
        1E1E1E3E0101010101010101010101010101010101010101010101010101015A
        1E1E1E3E0101010101010101010101010101010101010101010101010101015A
        1E1E1E3E01010101010101010101010101010101010101010101015D40454733
        1E1E1E2A464542538101010101010101010101010101010101011D291E1E1E1E
        1E1E1E1E1E1E1E1E6601010101010101010101010101010101010B281E1E1E1E
        1E1E1E1E1E1E1E1E7701010101010101010101010101010101017F2A1E1E1E1E
        1E1E1E1E1E1E1E1E6701010101010101010101010101010101010115464B6F34
        1E1E1E2D4C4B487106010101010101010101010101010101010101010101015A
        1E1E1E3E0101010101010101010101010101010101010101010101010101015A
        1E1E1E3E01010101010101010101010101010101010101010101010101010242
        1E1E1E301A01010101010101010101010101010101010101010101010107451E
        1E1E1E1E0C8001010101010101010101010101010101010101010101017E1E1E
        1E1E1E1E1E700101010101010101010101010101010101010101010101401E1E
        35184E1E1E2B1B01010101010101010101010101010101010101010101391E1E
        5501621E1E266901010101010101010101010101010101010101010101501E1E
        264D311E1E6C0601010101010101010101010101010101010101010101781E1E
        1E1E1E1E1F080101010101010101010101010101010101010101010101017221
        1E1E1E1E5701010101010101010101010101010101010101010101010101017A
        0E4A526401010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnToggleVisibleClick
    end
    object btnSettings: TSpeedButton
      Left = 146
      Top = 0
      Width = 35
      Height = 34
      Hint = #35774#32622
      Flat = True
      Glyph.Data = {
        06080000424D0608000000000000060400002800000020000000200000000100
        08000000000000040000120B0000120B0000F4000000F400000000000000FFFF
        FF00FFFEFD00FEFDFC00FEFAF500FDF9F300FEFCF900FDF8F000D88C0000D789
        0000D78A0000D78B0000D88C0100F3DBAF00F4DDB300F4DEB600F6E3C000F6E4
        C300F7E6C700F9EDD700FAEFDB00F9EEDA00FAEFDC00FBF2E200FBF2E300FBF3
        E500FCF5E900FCF6EB00FCF6EC00FDF8EF00FDF9F200FEFBF600FDFAF500D88D
        0000D88E0000D78C0000D98F0100D88D0100D88E0100D88F0100D78C0100D98F
        0200D88E0200D88F0200D98F0300D9900400D9900500D9910500D9910600DA92
        0700DA920800D9920800DA920900DA920A00DA930A00DA920B00DA930B00DA93
        0C00DA940C00DA940D00DB940E00DA940E00DB940F00DA950F00DB951000DB95
        1100DB961200DB961300DB971400DC971500DC981600DC991900DD9A1A00DD9A
        1B00DC9A1B00DD9A1C00DD9B1C00DD9B1D00DD9B1E00DD9C1E00DD9D2000DE9D
        2300DE9E2300DE9E2400DE9E2500DE9F2500DE9F2600DFA02800DFA02900DFA0
        2A00DFA12B00DFA22D00E0A32F00DFA32F00E0A43000E0A43100E0A43200E1A6
        3500E0A53500E0A63500E1A63600E1A83900E1A83A00E2A83B00E1A83B00E2AA
        3F00E2AB4100E3AB4200E3AC4300E3AC4400E3AC4500E3AD4500E3AD4600E3AE
        4700E4AE4900E4AF4A00E4B04D00E4B14F00E4B15000E5B25200E5B35200E5B3
        5300E6B45600E6B55700E5B45600E6B55800E5B55700E6B55900E6B65B00E6B7
        5B00E7B85F00E7B96100E7B96200E7BA6200E8BA6300E8BA6400E8BB6500E8BB
        6600E8BC6800E8BD6900E9BD6A00E9BE6C00E8BD6B00EAC07100E9BF7000EAC1
        7200E9C07100EAC17300EAC17400EAC27400EBC37800EAC37700EBC47900EBC4
        7A00EBC47B00ECC67D00ECC67E00EBC67D00ECC67F00ECC78000ECC78200ECC8
        8200ECC88400EDCA8700EDCB8800EDCB8900EECC8B00EDCB8A00EDCC8C00EECD
        8E00EDCC8D00EECE8F00EFCF9200EFCF9300EFD09500EFD19700F0D29900EFD2
        9900F0D29A00F0D39B00F0D49D00F1D59F00F0D49E00F1D6A200F1D6A300F1D7
        A400F2D8A600F2D8A700F2D9A900F2DAAB00F3DBAD00F3DBAE00F3DCAF00F3DC
        B000F3DCB100F3DDB100F3DDB200F4DEB500F5E0B800F4DFB800F5E1BA00F5E1
        BB00F5E3C000F6E5C300F7E6C600F7E7C800F7E7C900F7E8CC00F8EAD000F8EB
        D100F9ECD300F8EBD200F9ECD400F8EBD300F8ECD400F9EED800F9EED900FAF0
        DC00F9EFDB00FBF2E100FAF1E000FBF3E300FBF4E600FCF5E800FBF4E700FCF6
        EA00FDF8EE00FDF9F100FEFBF500FDFAF400FEFCF800FFFEFC00FEFDFB00F3DE
        B300F8EBD000FAF2E000FAF2E100FCF6E900FCF7EC00FDF9F000FDFAF300FEFD
        FA00FFFFFE00FFFFFF0001010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101E3DFE00702010101
        01010101010101010101010101010101010101010101EC6B564D4D5461CC0101
        01010101010101010101010101010101010101010101B0213434353408910101
        010101010101010101010101010101010101010101018F2376CDCE87287A0101
        010101010101010101010101010101010101010101196923A30101E92A5DD901
        010101010101010101010101010101CCAAEA011F984B3021C8010113342E4686
        1A0116ADC5010101010101010101D94F0B42777022225799EF0101E6A5602421
        627E47083CCB01010101010101E6722B473E0B2145A6EE010101010101E5B452
        2123344D2D6420010101010101C12C3CC9128C641101010101010101010101DA
        6A80C9D14922AD0101010101036D088A0101010201010101DFC9C71701010101
        01010101A82659E201010101D7382E8E0101010101011D934C21214685170101
        01010101A33321C5010101011F92292F7B19010101DE650B446F714E0A5AD801
        0101059532297DEE0101010101019D412390010101880A66D50101DC780B6F06
        0101AF08388BE70101010101010101710BA10101D6394EDD010101011F6121C5
        0101C82E4F1D0101010101010101036521B70101B80A88010101010101AB09A2
        0101D13C47EC0101010101010101026821B50101B20A9C010101010101B8099A
        0101D03B4ADD0101010101010101016E0B9901010F216C0101010101018A0AB4
        0101C32C4EED0101010101010104843A219B0101E55E2BA901010101BE374818
        0101B72434741C0101010101E3792732951F010101BF242E89C0C5973A08AE01
        0101E7AC3D29651701010101143F2E99010101010101B44C0A08210940A40101
        01010101B23322C601010101F277087F010101E2010101EBA778749ED4010101
        1EE701019621611F0101010101103136B3BB7050B901010101010101010101CA
        5867B10D442CBA0101010101010281263A290826348DDB010101010101E1A043
        240822392C6EE7010101010101011A60215392832D214E80E001011E8C552121
        73985B2C4AD201010101010101010114BC1C0101B65F3621C10101D33132519E
        1F01F0C2CF010101010101010101010101010101011F720B9F0101BD25621B01
        0101010101010101010101010101010101010101010194086DC40E7C0C7F0101
        01010101010101010101010101010101010101010101B7083027272E0B980101
        01010101010101010101010101010101010101010101EE82635C5D6375150101
        010101010101010101010101010101010101010101010101E8E4E4F101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSettingsClick
    end
    object btnStamp: TSpeedButton
      Left = 183
      Top = 0
      Width = 35
      Height = 34
      Hint = #22270#29255#30422#31456
      Flat = True
      Glyph.Data = {
        46060000424D4606000000000000460200002800000020000000200000000100
        08000000000000040000120B0000120B0000840000008400000000000000FFFF
        FF00FCFDFB00F9FCF700B8D7A900D8EBCF00F5F9F300FBFDFA00FAFCF900F0F7
        ED0096C88300D3E9CA00EBF5E700F5FAF300F4F9F200F3F8F1004BA12E008FC5
        7B00A6D19700B2D7A500B7DAAB00B6D9AA00B8DAAC00AFC6A700E1EFDC00E7F2
        E3002E920D00309A0F002E940E002E930E002F930E002E920E002F940F003094
        1000309411003295130035961600359717003697170036961700379818003999
        1A0038981A0039991B003A991B003B9A1D003E9B21003E9B2200419E2400419D
        2400439F2600439E2700459F2800469F2900459E290047A02A0049A12D004AA1
        2E004CA330004CA230004DA332004FA433004FA3330050A4350051A5360051A6
        370052A6380053A6390054A6390055A73A0056A83C0062AE4A0066B14E0065AF
        4D0069B152006EB558006EB3580071B55C0074B75E007CBD68007DBC690081BE
        6D0082BF6F008EC47C0090C67F0092C482009CCC8D00A1CF9200A5D09700ADD4
        A000AFD6A300B9DBAE00BBDCB100C2E0B900C3DFBA00C0D8B800CDE5C500D2E7
        CB00D4E9CD00D3E8CC00DAECD400DCEDD700E5F1E100EBF5E800EAF4E700EDF6
        EA00F3F9F100F9FCF8002D940F005EAC480068B153009DCE8F00A3D09600A5D1
        9900AFD6A400C6E2BE00CFE7C800D5EACF00D4E9CE00D8EBD300DBEDD600E1F0
        DD00E2F0DE00E8F3E500ABD8A000E6F3E300F8FCF700F6FAF500F6FBF500F4F9
        F300FDFEFD00FFFFFF000101566E3F343135464E130901010101010101010101
        01010101010101010101012D1D1D1D1D1D1D1D1D1D37577F0101010101010101
        010101010101010101010775441D1D1D1D1D1D1D1D1D1D447601010101010101
        010101010101010101010101662F1D1D1D1D1D1D1D1D1D1D2D73010101010101
        010101010101010101010101010A1D1D1D1D1D1D1D1D1D1D1D2B740101010101
        0101010101010101010101010105211D1D1D1D1D1D1D1D1D1D1D3A8001010101
        0101010101010101010101010166251D1D1D1D1D1D1D1D1D1D1D1D7001010101
        0101010101010101010101010164221D1D1D1D1D1D1D1D1D1D1D1D4701010101
        01010101010101010101010101161D1D1D1D1D1D1D1D1D1D1D1D1D397E010101
        01010101010101010101010101581D1D1D1D1D1D1D1D1D1D1D1D1D330E010101
        010101010101010101010101015C1D1D1D1D1D1D1D1D1D1D1D1D1D1003010101
        0101010101010101010101010165211D1D1D1D1D1D1D1D1D1D1D1D6D01010101
        0101010101010101010101010107451D1D1D1D1D1D1D1D1D1D1D1D1201010101
        0101010101010101010101010101141D1D1D1D1D1D1D1D1D1D1D380D01010101
        010101010101010101010101010182501D1D1D1D1D1D1D1D1D2A0B0101775B01
        01010101010101010101010101010108511C1D1D1D1D1D1D305D01017934205E
        01010101010101010101010101010101015F4B34242941556601017A3B1D1D36
        0C01010101010101010101010101010101010181187B020101010C431D1D1D1E
        4D01010101010101010101010101010101010101010101010119421D1D1D1D1D
        1D710101010101010101010101010101010101010101010101721D1D1D1D1D1D
        1D2C78010101010101010101010101010101010101010101016A111D1D1D1D1D
        1D1D4006010101010101010101010101010101010101010101010159261D1D1D
        1D1D1D52010101010101010101010101010101010101010101010101633C1D1D
        1D1D1D6C0401010101010101010101010101010101010101010101010168491D
        1D1D1D1D2E7D0101010101010101010101010101010101010101010101016B53
        1F1D1D1D1D498201010101010101010101010101010101010101010101010101
        7C271D1D1D1A6F01010101010101010101010101010101010101010101010101
        01613D1D1D1D2360010101010101010101010101010101010101010101010101
        0101694A1D1D1D3F0F0101010101010101010101010101010101010101010101
        01010107541D1D1D4F0101010101010101010101010101010101010101010101
        01010101015A281D1B1701010101010101010101010101010101010101010101
        010101010101623E1D3201010101010101010101010101010101010101010101
        0101010101010167484C}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnStampClick
    end
    object chkImage: TCheckBox
      Left = 14
      Top = 5
      Width = 50
      Height = 26
      Caption = #31456
      Checked = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
  end
  object dlgSavePDF: TSaveDialog
    Filter = 'PDF'#25991#20214'|*.pdf'
    Left = 372
    Top = 748
  end
  object dlgOpenForStamp: TOpenDialog
    Filter = 'JPG'#25110'PNG'#25991#20214'|*.jpg;*.png|PNG'#25991#20214'|*.png'
    Left = 436
    Top = 748
  end
  object dlgSaveStamp: TSaveDialog
    Filter = 'JPG'#25991#20214'|*.jpg'
    Left = 508
    Top = 748
  end
end
