;; skeleton .yas-setup.el file for coffee-mode
;; 
(load "/home/chris/Projects/yasmate/snippets/coffee-mode/.yasmate-menu.el")
(yas-define-menu 'coffee-mode
                 '(;; Ignoring Run
                   (yas-ignore-item "30395DAB-44A6-44F7-99E1-02D64621303A")
                   ;; Ignoring Run (Terminal)
                   (yas-ignore-item "51274A0F-82E2-4F1A-9434-875481425643")
                   ;; Ignoring Run Document / Selection
                   (yas-ignore-item "90424631-D00B-448C-B157-DAC92DFB2858")
                   
                   ;; Ignoring Compile and Display JS
                   (yas-ignore-item "D749F761-1740-4918-9490-90DF376BA72E")
                   
                   (yas-submenu "Control"
                                (;; If
                                 (yas-item "F4FDFB3A-71EF-48A4-93F4-178B949546B1")
                                 ;; If .. Else
                                 (yas-item "2AD19F12-E499-4715-9A47-FC8D594BC550")
                                 ;; Else If
                                 (yas-item "EA8F5EDB-6E1E-4C36-9CA5-12B108F1A7C9")
                                 ;; Ternary If
                                 (yas-item "CF0B4684-E4CB-4E10-8C25-4D15400C3385")
                                 ;; Unless
                                 (yas-item "E561AECD-5933-4F59-A6F7-FA96E1203606")))
                   (yas-submenu "Constructs"
                                (;; Ignoring New Function
                                 (yas-ignore-item "192428A1-8684-4172-8728-225B4C9E532F")
                                 ;; Function
                                 (yas-item "F2E2E79A-A85D-471D-9847-72AE40205942")
                                 ;; Function (Bound)
                                 (yas-item "20BDC055-ED67-4D0E-A47F-ADAA828EFF2B")
                                 ;; Class
                                 (yas-item "765ACBD3-380A-4CF8-9111-345A36A0DAE7")
                                 (yas-separator)
                                 ;; Array Comprehension
                                 (yas-item "2D4AC0B4-47AA-4E38-9A11-09A48C2A9439")
                                 ;; Object Comprehension
                                 (yas-item "9D126CC5-EA14-4A40-B6D3-6A5FC1AC1420")
                                 ;; Range Comprehension (Exclusive)
                                 (yas-item "FA6AB9BF-3444-4A8C-B010-C95C2CF5BAB3")
                                 ;; Range Comprehension (Inclusive)
                                 (yas-item "E0F8E45A-9262-4DD6-ADFF-B5B9D6CE99C2")
                                 ;; Switch
                                 (yas-item "3931A7C6-F1FB-484F-82D1-26F5A8F779D0")
                                 ;; Try .. Catch
                                 (yas-item "CAFB0DED-5E23-4A84-AC20-87FBAF22DBAC")))
                   (yas-submenu "Other"
                                (;; Ignoring Insert Heredoc """ Quotes
                                 (yas-ignore-item "F08537AF-4F02-4040-999D-F0785CF64C02")
                                 ;; Ignoring Insert Heredoc ''' Quotes
                                 (yas-ignore-item "C4F99E3D-1540-4BC1-8038-0A19D65BABC8")
                                 ;; Ignoring Insert Heredoc """ Comment
                                 (yas-ignore-item "68A86250-0280-11E0-A976-0800200C9A66")
                                 ;; Ignoring Align Assignments
                                 (yas-ignore-item "EE3293A5-3761-40BD-9CA8-DAAA176AA19E")
                                 ;; Raw JavaScript
                                 (yas-item "422A59E7-FC36-4E99-B01C-6353515BB544")
                                 ;; Require
                                 (yas-item "8A65E175-18F2-428F-A695-73E01139E41A")
                                 ;; Interpolated Code
                                 (yas-item "C04ED189-6ACB-44E6-AD5B-911B760AD1CC")
                                 ;; Log
                                 (yas-item "FBC44B18-323A-4C00-A35B-15E41830C5AD")
                                 (yas-separator)
                                 ;; Comment Header
                                 (yas-item "099276E4-DCF9-470B-9034-EFF7F0937560")
                                 ;; Comment Subheader
                                 (yas-item "EB7F835F-4F2F-4483-832B-BDA4AEE0EAB7")
                                 ;; Comment Sub-Subheader
                                 (yas-item "31EC9F11-C98B-4F07-9591-172B4B593EFE"))))
                    '("30395DAB-44A6-44F7-99E1-02D64621303A"
                       "90424631-D00B-448C-B157-DAC92DFB2858"
                       "68A86250-0280-11E0-A976-0800200C9A66"
                       "9A625AB5-11C9-447A-A255-2F6FB3F22011"
                       "C4F99E3D-1540-4BC1-8038-0A19D65BABC8"
                       "EE3293A5-3761-40BD-9CA8-DAAA176AA19E"
                       "D749F761-1740-4918-9490-90DF376BA72E"
                       "51274A0F-82E2-4F1A-9434-875481425643"
                       "F08537AF-4F02-4040-999D-F0785CF64C02"
                       "192428A1-8684-4172-8728-225B4C9E532F"))
