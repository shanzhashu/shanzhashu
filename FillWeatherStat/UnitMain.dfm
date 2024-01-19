object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #27668#35937#26680#26597#25253#21578#19968#38190#24335#29983#25104#31995#32479
  ClientHeight = 828
  ClientWidth = 629
  Color = clBtnFace
  Constraints.MaxWidth = 637
  Constraints.MinWidth = 637
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
    629
    828)
  PixelsPerInch = 96
  TextHeight = 12
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 629
    Height = 828
    ActivePage = ts1
    Align = alClient
    TabOrder = 0
    TabPosition = tpBottom
    object ts1: TTabSheet
      Caption = #27668#28201
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 621
        Height = 802
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          621
          802)
        object fcpSheet1: TFlexCelPreviewer
          Left = 0
          Top = 0
          Width = 603
          Height = 800
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 810
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
          object lbl1BiaoZhunQi: TLabel
            Left = 144
            Top = 176
            Width = 48
            Height = 12
            Caption = #26631#20934#22120#65306
            Transparent = True
          end
          object cbb1BiaoZhunQi: TComboBox
            Left = 198
            Top = 171
            Width = 115
            Height = 20
            Style = csDropDownList
            TabOrder = 6
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
          end
          object edt1KaiShiShiJian: TEdit
            Left = 201
            Top = 148
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 4
            Text = '13:10'
          end
          object edt1JieShuShiJian: TEdit
            Left = 459
            Top = 148
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 5
            Text = '15:10'
          end
          object cbb1HeGe: TComboBox
            Left = 216
            Top = 618
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 24
            Text = #21512#26684
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object edt1JiaoZhunShiJian: TEdit
            Left = 419
            Top = 686
            Width = 121
            Height = 20
            TabOrder = 29
            Text = '2023'#24180'12'#26376'31'#26085
          end
          object cbb1BeiHeCha: TComboBox
            Left = 398
            Top = 171
            Width = 115
            Height = 20
            TabOrder = 7
          end
          object cbb1WaiGuanHeGe: TComboBox
            Left = 123
            Top = 396
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 8
            Text = #21512#26684
            Items.Strings = (
              #21512#26684
              #19981#21512#26684)
          end
          object cbb1FuHeYaoQiu: TComboBox
            Left = 216
            Top = 664
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 26
            Text = #26159
            Items.Strings = (
              #26159
              #21542)
          end
          object cbb1JiaoZhun: TComboBox
            Left = 96
            Top = 684
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 27
          end
          object cbb1HeYan: TComboBox
            Left = 252
            Top = 684
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 28
          end
          object cbb1HeChaYiJu: TComboBox
            Left = 216
            Top = 640
            Width = 323
            Height = 20
            Style = csDropDownList
            TabOrder = 25
          end
          object edt1JiLuBianHao: TEdit
            Left = 392
            Top = 101
            Width = 150
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(T)23030150101'
          end
          object edt1BeiHeCha1: TEdit
            Left = 416
            Top = 469
            Width = 70
            Height = 20
            TabOrder = 12
            Text = '-10.113'
            OnChange = UpdateSheet1
          end
          object edt1BeiHeCha2: TEdit
            Left = 416
            Top = 525
            Width = 70
            Height = 20
            TabOrder = 17
            Text = '-0.089'
            OnChange = UpdateSheet1
          end
          object edt1BeiHeCha3: TEdit
            Left = 416
            Top = 579
            Width = 70
            Height = 20
            TabOrder = 21
            Text = '29.983'
            OnChange = UpdateSheet1
          end
          object edt1XiuZhengZhi1: TEdit
            Left = 217
            Top = 469
            Width = 100
            Height = 20
            TabOrder = 11
            Text = '-0.003'
            OnChange = UpdateSheet1
          end
          object edt1XiuZhengZhi2: TEdit
            Left = 217
            Top = 525
            Width = 100
            Height = 20
            TabOrder = 16
            Text = '-0.005'
            OnChange = UpdateSheet1
          end
          object edt1XiuZhengZhi3: TEdit
            Left = 217
            Top = 579
            Width = 100
            Height = 20
            TabOrder = 20
            Text = '-0.013'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi1: TEdit
            Left = 125
            Top = 451
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '-9.992'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi2: TEdit
            Left = 125
            Top = 469
            Width = 90
            Height = 20
            TabOrder = 10
            Text = '-9.989'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi3: TEdit
            Left = 125
            Top = 487
            Width = 90
            Height = 20
            TabOrder = 13
            Text = '-9.996'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi4: TEdit
            Left = 125
            Top = 506
            Width = 90
            Height = 20
            TabOrder = 14
            Text = '0.024'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi5: TEdit
            Left = 125
            Top = 525
            Width = 90
            Height = 20
            TabOrder = 15
            Text = '0.035'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi6: TEdit
            Left = 125
            Top = 544
            Width = 90
            Height = 20
            TabOrder = 18
            Text = '0.031'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi7: TEdit
            Left = 125
            Top = 563
            Width = 90
            Height = 20
            TabOrder = 19
            Text = '30.102'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi8: TEdit
            Left = 125
            Top = 581
            Width = 90
            Height = 20
            TabOrder = 22
            Text = '30.095'
            OnChange = UpdateSheet1
          end
          object edt1BiaoZhunZhi9: TEdit
            Left = 125
            Top = 599
            Width = 90
            Height = 20
            TabOrder = 23
            Text = '30.092'
            OnChange = UpdateSheet1
          end
        end
      end
    end
    object ts2: TTabSheet
      Caption = #28287#24230
      ImageIndex = 1
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 621
        Height = 802
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          621
          802)
        object fcpSheet2: TFlexCelPreviewer
          Left = 0
          Top = 1
          Width = 603
          Height = 800
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 810
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
          object lbl2BiaoZhunQi: TLabel
            Left = 152
            Top = 178
            Width = 48
            Height = 12
            Caption = #26631#20934#22120#65306
            Transparent = True
          end
          object edt2JiLuBianHao: TEdit
            Left = 396
            Top = 97
            Width = 156
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(TH)23030150101'
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
          object edt2KaiShiShiJian: TEdit
            Left = 210
            Top = 147
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet2
          end
          object edt2JieShuShiJian: TEdit
            Left = 460
            Top = 147
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 5
            Text = '15:50'
            OnChange = UpdateSheet2
          end
          object cbb2BiaoZhunQi: TComboBox
            Left = 206
            Top = 173
            Width = 115
            Height = 20
            Style = csDropDownList
            TabOrder = 6
            OnChange = UpdateSheet2
          end
          object cbb2BeiHeCha: TComboBox
            Left = 404
            Top = 173
            Width = 115
            Height = 20
            TabOrder = 7
            OnChange = UpdateSheet2
          end
          object cbb2WaiGuanHeGe: TComboBox
            Left = 139
            Top = 412
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 8
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
            TabOrder = 19
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
            TabOrder = 20
            OnChange = UpdateSheet2
          end
          object cbb2FuHeYaoQiu: TComboBox
            Left = 139
            Top = 664
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 21
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
            TabOrder = 22
            OnChange = UpdateSheet2
          end
          object cbb2HeYan: TComboBox
            Left = 260
            Top = 692
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 23
            OnChange = UpdateSheet2
          end
          object edt2JiaoZhunShiJian: TEdit
            Left = 412
            Top = 694
            Width = 140
            Height = 20
            TabOrder = 24
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi1: TEdit
            Left = 139
            Top = 473
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '86.6'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi2: TEdit
            Left = 139
            Top = 496
            Width = 90
            Height = 20
            TabOrder = 10
            Text = '86.8'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi3: TEdit
            Left = 139
            Top = 519
            Width = 90
            Height = 20
            TabOrder = 13
            Text = '87.0'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi4: TEdit
            Left = 139
            Top = 542
            Width = 90
            Height = 20
            TabOrder = 14
            Text = '33.0'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi5: TEdit
            Left = 139
            Top = 563
            Width = 90
            Height = 20
            TabOrder = 17
            Text = '33.1'
            OnChange = UpdateSheet2
          end
          object edt2BiaoZhunZhi6: TEdit
            Left = 139
            Top = 584
            Width = 90
            Height = 20
            TabOrder = 18
            Text = '33.2'
            OnChange = UpdateSheet2
          end
          object edt2XiuZhengZhi1: TEdit
            Left = 231
            Top = 496
            Width = 100
            Height = 20
            TabOrder = 11
            Text = '1.2'
            OnChange = UpdateSheet2
          end
          object edt2XiuZhengZhi2: TEdit
            Left = 231
            Top = 560
            Width = 100
            Height = 20
            TabOrder = 15
            Text = '-1.7'
            OnChange = UpdateSheet2
          end
          object edt2BeiHeCha1: TEdit
            Left = 419
            Top = 496
            Width = 70
            Height = 20
            TabOrder = 12
            Text = '92.2'
            OnChange = UpdateSheet2
          end
          object edt2BeiHeCha2: TEdit
            Left = 419
            Top = 560
            Width = 70
            Height = 20
            TabOrder = 16
            Text = '34.3'
            OnChange = UpdateSheet2
          end
        end
      end
    end
    object ts3: TTabSheet
      Caption = #39118#21521
      ImageIndex = 1
      object ScrollBox3: TScrollBox
        Left = 0
        Top = 0
        Width = 621
        Height = 802
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          621
          802)
        object fcpSheet3: TFlexCelPreviewer
          Left = 0
          Top = 0
          Width = 603
          Height = 800
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 810
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
          object lbl3BiaoZhunQi: TLabel
            Left = 152
            Top = 192
            Width = 48
            Height = 12
            Caption = #26631#20934#22120#65306
            Transparent = True
          end
          object cbb3FuHeYaoQiu: TComboBox
            Left = 234
            Top = 640
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 14
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
            TabOrder = 13
            OnChange = UpdateSheet3
          end
          object cbb3HeGe: TComboBox
            Left = 234
            Top = 592
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 12
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
            TabOrder = 8
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
            TabOrder = 7
            OnChange = UpdateSheet3
          end
          object cbb3BiaoZhunQi: TComboBox
            Left = 206
            Top = 189
            Width = 115
            Height = 20
            Style = csDropDownList
            TabOrder = 6
            OnChange = UpdateSheet3
          end
          object edt3KaiShiShiJian: TEdit
            Left = 209
            Top = 164
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
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
          object edt3JieShuShiJian: TEdit
            Left = 467
            Top = 164
            Width = 46
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
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
            Text = 'G-7231-H(VX)23030150101'
            OnChange = UpdateSheet3
          end
          object cbb3JiaoZhun: TComboBox
            Left = 98
            Top = 664
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 15
            OnChange = UpdateSheet3
          end
          object edt3JiaoZhunShiJian: TEdit
            Left = 431
            Top = 664
            Width = 121
            Height = 20
            TabOrder = 17
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet3
          end
          object cbb3HeYan: TComboBox
            Left = 270
            Top = 664
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 16
            OnChange = UpdateSheet3
          end
          object edt3BeiHeCha1: TEdit
            Left = 125
            Top = 482
            Width = 106
            Height = 20
            TabOrder = 9
            Text = '0'
            OnChange = UpdateSheet3
          end
          object edt3BeiHeCha2: TEdit
            Left = 125
            Top = 520
            Width = 106
            Height = 20
            TabOrder = 10
            Text = '120'
            OnChange = UpdateSheet3
          end
          object edt3BeiHeCha3: TEdit
            Left = 125
            Top = 560
            Width = 106
            Height = 20
            TabOrder = 11
            Text = '241'
            OnChange = UpdateSheet3
          end
        end
      end
    end
    object ts4: TTabSheet
      Caption = #39118#36895
      ImageIndex = 1
      object ScrollBox4: TScrollBox
        Left = 0
        Top = 0
        Width = 621
        Height = 802
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          621
          802)
        object fcpSheet4: TFlexCelPreviewer
          Left = 0
          Top = -1
          Width = 603
          Height = 800
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 810
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
          object lbl4BiaoZhunQi: TLabel
            Left = 156
            Top = 188
            Width = 48
            Height = 12
            Caption = #26631#20934#22120#65306
            Transparent = True
          end
          object edt4JiLuBianHao: TEdit
            Left = 388
            Top = 107
            Width = 156
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(VX)23030150101'
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
          object edt4JieShuShiJian: TEdit
            Left = 468
            Top = 159
            Width = 46
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet4
          end
          object cbb4BeiHeCha: TComboBox
            Left = 406
            Top = 185
            Width = 115
            Height = 20
            TabOrder = 7
            OnChange = UpdateSheet4
          end
          object cbb4BiaoZhunQi: TComboBox
            Left = 210
            Top = 185
            Width = 115
            Height = 20
            Style = csDropDownList
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
            TabOrder = 8
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
            TabOrder = 19
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
            TabOrder = 20
            OnChange = UpdateSheet4
          end
          object cbb4FuHeYaoQiu: TComboBox
            Left = 232
            Top = 659
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 21
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
            TabOrder = 24
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet4
          end
          object cbb4JiaoZhun: TComboBox
            Left = 106
            Top = 682
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 22
            OnChange = UpdateSheet4
          end
          object cbb4HeYan: TComboBox
            Left = 269
            Top = 682
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 23
            OnChange = UpdateSheet4
          end
          object edt4KaiShiShiJian: TEdit
            Left = 212
            Top = 159
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet3
          end
          object edt4BiaoZhunZhi1: TEdit
            Left = 137
            Top = 474
            Width = 90
            Height = 20
            TabOrder = 9
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
            TabOrder = 13
            Text = '10.0'
            OnChange = UpdateSheet4
          end
          object edt4BiaoZhunZhi4: TEdit
            Left = 137
            Top = 554
            Width = 90
            Height = 20
            TabOrder = 15
            Text = '20.2'
            OnChange = UpdateSheet4
          end
          object edt4BiaoZhunZhi5: TEdit
            Left = 137
            Top = 581
            Width = 90
            Height = 20
            TabOrder = 17
            Text = '40.4'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha1: TEdit
            Left = 233
            Top = 474
            Width = 90
            Height = 20
            TabOrder = 10
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
            TabOrder = 14
            Text = '10.0'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha4: TEdit
            Left = 233
            Top = 554
            Width = 90
            Height = 20
            TabOrder = 16
            Text = '20.1'
            OnChange = UpdateSheet4
          end
          object edt4BeiHeCha5: TEdit
            Left = 233
            Top = 581
            Width = 90
            Height = 20
            TabOrder = 18
            Text = '40.4'
            OnChange = UpdateSheet4
          end
        end
      end
    end
    object ts5: TTabSheet
      Caption = #27668#21387
      ImageIndex = 1
      object ScrollBox5: TScrollBox
        Left = 0
        Top = 0
        Width = 621
        Height = 802
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          621
          802)
        object fcpSheet5: TFlexCelPreviewer
          Left = 0
          Top = -1
          Width = 603
          Height = 800
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 810
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl5BiaoZhunQi: TLabel
            Left = 146
            Top = 189
            Width = 48
            Height = 12
            Caption = #26631#20934#22120#65306
            Transparent = True
          end
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
            Text = 'G-7231-H(P)23030150101'
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
          object edt5JieShuShiJian: TEdit
            Left = 463
            Top = 160
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet5
          end
          object edt5KaiShiShiJian: TEdit
            Left = 207
            Top = 160
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet5
          end
          object cbb5BiaoZhunQi: TComboBox
            Left = 202
            Top = 185
            Width = 115
            Height = 20
            Style = csDropDownList
            TabOrder = 6
            OnChange = UpdateSheet5
          end
          object cbb5BeiHeCha: TComboBox
            Left = 400
            Top = 185
            Width = 115
            Height = 20
            TabOrder = 7
            OnChange = UpdateSheet5
          end
          object cbb5WaiGuanHeGe: TComboBox
            Left = 127
            Top = 392
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 8
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
            TabOrder = 24
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
            TabOrder = 25
            OnChange = UpdateSheet5
          end
          object cbb5FuHeYaoQiu: TComboBox
            Left = 217
            Top = 670
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 26
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
            TabOrder = 29
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet5
          end
          object cbb5JiaoZhun: TComboBox
            Left = 92
            Top = 693
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 27
            OnChange = UpdateSheet5
          end
          object cbb5HeYan: TComboBox
            Left = 250
            Top = 693
            Width = 77
            Height = 20
            Style = csDropDownList
            TabOrder = 28
            OnChange = UpdateSheet5
          end
          object edt5BeiHeCha1: TEdit
            Left = 416
            Top = 472
            Width = 70
            Height = 20
            TabOrder = 12
            Text = '950.10'
            OnChange = UpdateSheet5
          end
          object edt5BeiHeCha2: TEdit
            Left = 416
            Top = 528
            Width = 70
            Height = 20
            TabOrder = 17
            Text = '1000.10'
            OnChange = UpdateSheet5
          end
          object edt5BeiHeCha3: TEdit
            Left = 416
            Top = 582
            Width = 70
            Height = 20
            TabOrder = 22
            Text = '1050.00'
            OnChange = UpdateSheet5
          end
          object edt5XiuZhengZhi1: TEdit
            Left = 217
            Top = 472
            Width = 100
            Height = 20
            TabOrder = 11
            Text = '-0.04'
            OnChange = UpdateSheet5
          end
          object edt5XiuZhengZhi2: TEdit
            Left = 217
            Top = 528
            Width = 100
            Height = 20
            TabOrder = 16
            Text = '-0.04'
            OnChange = UpdateSheet5
          end
          object edt5XiuZhengZhi3: TEdit
            Left = 217
            Top = 582
            Width = 100
            Height = 20
            TabOrder = 21
            Text = '-0.04'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi1: TEdit
            Left = 125
            Top = 449
            Width = 90
            Height = 20
            TabOrder = 9
            Text = '950'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi2: TEdit
            Left = 125
            Top = 468
            Width = 90
            Height = 20
            TabOrder = 10
            Text = '950'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi3: TEdit
            Left = 125
            Top = 487
            Width = 90
            Height = 20
            TabOrder = 13
            Text = '950'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi6: TEdit
            Left = 125
            Top = 544
            Width = 90
            Height = 20
            TabOrder = 18
            Text = '1000'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi5: TEdit
            Left = 125
            Top = 525
            Width = 90
            Height = 20
            TabOrder = 15
            Text = '1000'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi4: TEdit
            Left = 125
            Top = 506
            Width = 90
            Height = 20
            TabOrder = 14
            Text = '1000'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi7: TEdit
            Left = 125
            Top = 563
            Width = 90
            Height = 20
            TabOrder = 19
            Text = '1050'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi8: TEdit
            Left = 125
            Top = 582
            Width = 90
            Height = 20
            TabOrder = 20
            Text = '1050'
            OnChange = UpdateSheet5
          end
          object edt5BiaoZhunZhi9: TEdit
            Left = 125
            Top = 601
            Width = 90
            Height = 20
            TabOrder = 23
            Text = '1050'
            OnChange = UpdateSheet5
          end
        end
      end
    end
    object ts6: TTabSheet
      Caption = #38632#37327
      ImageIndex = 1
      object ScrollBox6: TScrollBox
        Left = 0
        Top = 0
        Width = 621
        Height = 802
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          621
          802)
        object fcpSheet6: TFlexCelPreviewer
          Left = 0
          Top = -1
          Width = 603
          Height = 800
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 810
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          Zoom = 0.700000000000000000
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object lbl6BiaoZhunQi: TLabel
            Left = 146
            Top = 192
            Width = 48
            Height = 12
            Caption = #26631#20934#22120#65306
            Transparent = True
          end
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
            Text = 'G-7231-H(R)23030150101'
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
          object edt6KaiShiShiJian: TEdit
            Left = 207
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet6
          end
          object edt6JieShuShiJian: TEdit
            Left = 463
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet6
          end
          object cbb6BiaoZhunQi: TComboBox
            Left = 200
            Top = 187
            Width = 115
            Height = 20
            Style = csDropDownList
            TabOrder = 6
            OnChange = UpdateSheet6
          end
          object cbb6BeiHeCha: TComboBox
            Left = 400
            Top = 188
            Width = 115
            Height = 20
            TabOrder = 7
            OnChange = UpdateSheet6
          end
          object cbb6WaiGuanHeGe: TComboBox
            Left = 125
            Top = 430
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 8
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
            TabOrder = 15
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
            TabOrder = 16
            OnChange = UpdateSheet6
          end
          object cbb6FuHeYaoQiu: TComboBox
            Left = 216
            Top = 654
            Width = 65
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 17
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
            TabOrder = 19
            OnChange = UpdateSheet6
          end
          object cbb6JiaoZhun: TComboBox
            Left = 116
            Top = 676
            Width = 65
            Height = 20
            Style = csDropDownList
            TabOrder = 18
            OnChange = UpdateSheet6
          end
          object edt6JiaoZhunShiJian: TEdit
            Left = 412
            Top = 676
            Width = 132
            Height = 20
            TabOrder = 20
            Text = '2023'#24180'12'#26376'31'#26085
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi1: TEdit
            Left = 321
            Top = 489
            Width = 94
            Height = 20
            TabOrder = 9
            Text = '10.2'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi2: TEdit
            Left = 321
            Top = 508
            Width = 94
            Height = 20
            TabOrder = 10
            Text = '10.3'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi3: TEdit
            Left = 321
            Top = 527
            Width = 94
            Height = 20
            TabOrder = 11
            Text = '10.2'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi4: TEdit
            Left = 321
            Top = 546
            Width = 94
            Height = 20
            TabOrder = 12
            Text = '10.3'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi5: TEdit
            Left = 321
            Top = 564
            Width = 94
            Height = 20
            TabOrder = 13
            Text = '10.3'
            OnChange = UpdateSheet6
          end
          object edt6ChuanGanQi6: TEdit
            Left = 321
            Top = 581
            Width = 94
            Height = 20
            TabOrder = 14
            Text = '10.3'
            OnChange = UpdateSheet6
          end
        end
      end
    end
    object ts7: TTabSheet
      Caption = #36215#21160#39118
      ImageIndex = 1
      object ScrollBox7: TScrollBox
        Left = 0
        Top = 0
        Width = 621
        Height = 802
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          621
          802)
        object fcpSheet7: TFlexCelPreviewer
          Left = 0
          Top = 0
          Width = 603
          Height = 800
          Margins.Top = 1
          HorzScrollBar.Range = 20
          HorzScrollBar.Tracking = True
          VertScrollBar.Range = 810
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
          object lbl7BiaoZhunQi: TLabel
            Left = 150
            Top = 192
            Width = 48
            Height = 12
            Caption = #26631#20934#22120#65306
            Transparent = True
          end
          object edt7JiLuBianHao: TEdit
            Left = 396
            Top = 111
            Width = 154
            Height = 20
            TabOrder = 0
            Text = 'G-7231-H(VS)23030150101'
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
          object edt7JieShuShiJian: TEdit
            Left = 462
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 5
            Text = '15:10'
            OnChange = UpdateSheet7
          end
          object edt7KaiShiShiJian: TEdit
            Left = 204
            Top = 163
            Width = 41
            Height = 20
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 4
            Text = '13:10'
            OnChange = UpdateSheet7
          end
          object cbb7BiaoZhunQi: TComboBox
            Left = 202
            Top = 189
            Width = 115
            Height = 20
            Style = csDropDownList
            TabOrder = 6
            OnChange = UpdateSheet7
          end
          object cbb7BeiHeCha: TComboBox
            Left = 403
            Top = 189
            Width = 115
            Height = 20
            TabOrder = 7
            OnChange = UpdateSheet7
          end
          object cbb7WaiGuanHeGe: TComboBox
            Left = 125
            Top = 430
            Width = 81
            Height = 20
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 8
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
            TabOrder = 9
            OnChange = UpdateSheet7
          end
          object edt7BiaoZhunZhi2: TEdit
            Left = 125
            Top = 535
            Width = 192
            Height = 20
            TabOrder = 10
            OnChange = UpdateSheet7
          end
          object edt7BiaoZhunZhi3: TEdit
            Left = 124
            Top = 569
            Width = 192
            Height = 20
            TabOrder = 12
            OnChange = UpdateSheet7
          end
          object edt7HeChaJieGuo: TEdit
            Left = 345
            Top = 535
            Width = 192
            Height = 20
            TabOrder = 11
            Text = '0.0'
            OnChange = UpdateSheet7
          end
        end
      end
    end
  end
  object pnlMain: TPanel
    Left = 400
    Top = 810
    Width = 207
    Height = 20
    Anchors = [akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object btnPDF: TSpeedButton
      Left = 16
      Top = -2
      Width = 23
      Height = 22
      Hint = #36755#20986#25104'PDF'#25991#20214
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFF9999999999FFFFF98FFFFFFFF89FFFF9FFFFFFFFFF9FFFF9F897FFFF
        FF9FFFF9F989FF899F9FFFF9F899999F9F9FFFF9FFF9F9998F9FFFF9FFF899FF
        FF9FFFF9FFF999FFFF9FFFF9FFF989FFFF9FFFF9FFF898FFFF9FFFF9FFFFFFFF
        F89FFFF9FFFFFFFF89FFFFF98FFFFFF898FFFFFF999999998FFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPDFClick
    end
    object btnToggleVisible: TSpeedButton
      Left = 45
      Top = -2
      Width = 23
      Height = 22
      Hint = #20999#25442#26174#31034#27169#24335
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFF33FFF
        FFFFFFFFFF3333FFFFFFFFFF33BBB333FFFFFFF3BBBBBBB33FFFFF3BB33BB33B
        33FFF3BF3F3BB3F3B33FF3F3FF3BB3FF3B3FFF3FFF3BB3FFF3FFFFFFFF3BB3FF
        FFFFFFFFFF3BB3FFFFFFFFFFFF3BB3FFFFFFFFFFF3FBFB3FFFFFFFFF3FB33BB3
        FFFFFFFFF3FBFB3FFFFFFFFFFF3FB3FFFFFFFFFFFFF33FFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnToggleVisibleClick
    end
    object btnSettings: TSpeedButton
      Left = 74
      Top = -2
      Width = 23
      Height = 22
      Hint = #35774#32622
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFF33FF8C
        C8FFFFF3FF3F8CCCCCC8FF33383FCC8CC8CCF33B338FC8FCCF8CFF33BB8FFF8C
        C8FFFF83B3388FCCCCFF333883FFFFCCCCF33BBB38FFFFFCCFF33B8B38FFFFFF
        FFB3333883FFFF388333FF83B338833B38FFFF33BB8338BB33FFF33B338BB833
        B33FFF333838B38333FFFFF3FF3BB3FF3FFFFFFFFF3333FFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSettingsClick
    end
    object btnStamp: TSpeedButton
      Left = 103
      Top = -2
      Width = 23
      Height = 22
      Hint = #22270#29255#30422#31456
      Flat = True
      Glyph.Data = {
        66010000424D6601000000000000760000002800000013000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333F000030030000003333333337000033333330F0003333333B00003333
        33330F000333333000003333333330F00033333700003333333330F000333330
        00003333333300F00003333A0000333333300FF0000333370000333333300F00
        00033337000033333300FF000000333E00003333330FF0000000333700003333
        330FF00000003337000033333300F0000000333F000033333330000000033337
        0000333333330FFF003333370000333333330FFF0033333F0000333333330FFF
        0033333E0000333333330FFF0033333700003333333330000333333F00003333
        33333333333333300000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnStampClick
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
