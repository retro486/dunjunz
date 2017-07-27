; BBC Master Dunjunz song data
;
; Music composed by Julian Avis
;
; This "recording" obtained by modifying Beebem to dump sound register &
; timing information.  Result broken into 960ms (usually) chunks and
; analysed for repeats.
;
; The data is a little opaque, so frequency and timing annotations have
; been included!

; Song data.  Initial byte indicates duration in units of 10ms.  Followed
; by three pairs of pointers, one per channel, indicating attentuation
; pattern and frequency pattern to use.

	fcb 97
	fdb song_att_0,song_freq_0	; c0
	fdb song_att_0,song_freq_1	; c1
	fdb song_att_1,song_freq_2	; c2

	fcb 98
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_3,song_freq_3	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_6	; c0
	fdb song_att_7,song_freq_7	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_8,song_freq_8	; c0
	fdb song_att_9,song_freq_9	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_10,song_freq_8	; c0
	fdb song_att_11,song_freq_10	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_12,song_freq_8	; c0
	fdb song_att_13,song_freq_11	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_14,song_freq_8	; c0
	fdb song_att_15,song_freq_12	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_16,song_freq_8	; c0
	fdb song_att_17,song_freq_13	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_18,song_freq_8	; c0
	fdb song_att_19,song_freq_14	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_21,song_freq_15	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_16	; c0
	fdb song_att_22,song_freq_17	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_23,song_freq_20	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_24,song_freq_22	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_25,song_freq_24	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_20,song_freq_25	; c0
	fdb song_att_26,song_freq_26	; c1
	fdb song_att_5,song_freq_27	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_23,song_freq_9	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_24,song_freq_10	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_25,song_freq_11	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_27,song_freq_12	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_28,song_freq_13	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_29,song_freq_14	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_30,song_freq_15	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_31,song_freq_28	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_32,song_freq_29	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_16	; c0
	fdb song_att_2,song_freq_30	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_33,song_freq_24	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_20,song_freq_25	; c0
	fdb song_att_34,song_freq_31	; c1
	fdb song_att_5,song_freq_27	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_32,song_freq_29	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_16	; c0
	fdb song_att_2,song_freq_32	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_33,song_freq_33	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 97
	fdb song_att_20,song_freq_34	; c0
	fdb song_att_35,song_freq_35	; c1
	fdb song_att_36,song_freq_36	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_37,song_freq_12	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_38,song_freq_13	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_39,song_freq_37	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_32,song_freq_29	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_16	; c0
	fdb song_att_2,song_freq_30	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_33,song_freq_24	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_20,song_freq_25	; c0
	fdb song_att_34,song_freq_31	; c1
	fdb song_att_5,song_freq_27	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_32,song_freq_29	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_16	; c0
	fdb song_att_2,song_freq_32	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_33,song_freq_33	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_40,song_freq_38	; c0
	fdb song_att_35,song_freq_39	; c1
	fdb song_att_5,song_freq_27	; c2

	fcb 96
	fdb song_att_41,song_freq_40	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_42,song_freq_41	; c0
	fdb song_att_37,song_freq_12	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_43,song_freq_42	; c0
	fdb song_att_38,song_freq_13	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_44,song_freq_43	; c0
	fdb song_att_45,song_freq_14	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_46,song_freq_44	; c0
	fdb song_att_47,song_freq_15	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_48,song_freq_40	; c0
	fdb song_att_49,song_freq_9	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_45	; c0
	fdb song_att_50,song_freq_10	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_46	; c0
	fdb song_att_51,song_freq_47	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_52,song_freq_48	; c0
	fdb song_att_9,song_freq_49	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_6	; c0
	fdb song_att_53,song_freq_50	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_52,song_freq_51	; c0
	fdb song_att_23,song_freq_52	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_53	; c0
	fdb song_att_54,song_freq_54	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_52,song_freq_55	; c0
	fdb song_att_23,song_freq_56	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_2,song_freq_57	; c0
	fdb song_att_54,song_freq_58	; c1
	fdb song_att_5,song_freq_59	; c2

	fcb 96
	fdb song_att_52,song_freq_60	; c0
	fdb song_att_23,song_freq_49	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_7,song_freq_46	; c0
	fdb song_att_54,song_freq_62	; c1
	fdb song_att_5,song_freq_63	; c2

	fcb 96
	fdb song_att_9,song_freq_64	; c0
	fdb song_att_23,song_freq_49	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_53,song_freq_65	; c0
	fdb song_att_54,song_freq_50	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_23,song_freq_66	; c0
	fdb song_att_23,song_freq_52	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_54,song_freq_67	; c0
	fdb song_att_54,song_freq_54	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_23,song_freq_68	; c0
	fdb song_att_23,song_freq_56	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_54,song_freq_69	; c0
	fdb song_att_54,song_freq_58	; c1
	fdb song_att_5,song_freq_59	; c2

	fcb 96
	fdb song_att_23,song_freq_70	; c0
	fdb song_att_23,song_freq_49	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_24,song_freq_71	; c0
	fdb song_att_24,song_freq_62	; c1
	fdb song_att_5,song_freq_63	; c2

	fcb 96
	fdb song_att_25,song_freq_72	; c0
	fdb song_att_25,song_freq_73	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_27,song_freq_74	; c0
	fdb song_att_27,song_freq_75	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_28,song_freq_76	; c0
	fdb song_att_28,song_freq_77	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_29,song_freq_78	; c0
	fdb song_att_29,song_freq_79	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 97
	fdb song_att_55,song_freq_80	; c0
	fdb song_att_55,song_freq_81	; c1
	fdb song_att_56,song_freq_82	; c2

	fcb 96
	fdb song_att_57,song_freq_70	; c0
	fdb song_att_57,song_freq_49	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_58,song_freq_71	; c0
	fdb song_att_58,song_freq_62	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_83	; c0
	fdb song_att_7,song_freq_84	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_85	; c0
	fdb song_att_59,song_freq_86	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_60,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_61,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_62,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_64,song_freq_93	; c0
	fdb song_att_2,song_freq_86	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_65,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_66,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_67,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_59	; c2

	fcb 96
	fdb song_att_68,song_freq_93	; c0
	fdb song_att_2,song_freq_86	; c1
	fdb song_att_6,song_freq_61	; c2

	fcb 96
	fdb song_att_69,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_70,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_71,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_68,song_freq_93	; c0
	fdb song_att_2,song_freq_86	; c1
	fdb song_att_6,song_freq_95	; c2

	fcb 96
	fdb song_att_69,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_96	; c2

	fcb 96
	fdb song_att_70,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_97	; c2

	fcb 96
	fdb song_att_71,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_98	; c2

	fcb 96
	fdb song_att_68,song_freq_93	; c0
	fdb song_att_2,song_freq_86	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_69,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_70,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_71,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_68,song_freq_93	; c0
	fdb song_att_2,song_freq_86	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_69,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_70,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_71,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_59	; c2

	fcb 96
	fdb song_att_68,song_freq_93	; c0
	fdb song_att_2,song_freq_86	; c1
	fdb song_att_6,song_freq_61	; c2

	fcb 96
	fdb song_att_69,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_70,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_71,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_68,song_freq_93	; c0
	fdb song_att_2,song_freq_86	; c1
	fdb song_att_6,song_freq_95	; c2

	fcb 96
	fdb song_att_69,song_freq_87	; c0
	fdb song_att_2,song_freq_88	; c1
	fdb song_att_5,song_freq_96	; c2

	fcb 96
	fdb song_att_70,song_freq_89	; c0
	fdb song_att_2,song_freq_90	; c1
	fdb song_att_4,song_freq_97	; c2

	fcb 96
	fdb song_att_71,song_freq_91	; c0
	fdb song_att_63,song_freq_92	; c1
	fdb song_att_5,song_freq_98	; c2

	fcb 96
	fdb song_att_68,song_freq_99	; c0
	fdb song_att_2,song_freq_100	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_72,song_freq_101	; c0
	fdb song_att_2,song_freq_102	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_73,song_freq_103	; c0
	fdb song_att_2,song_freq_100	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_74,song_freq_104	; c0
	fdb song_att_2,song_freq_102	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_75,song_freq_105	; c0
	fdb song_att_2,song_freq_100	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_76,song_freq_106	; c0
	fdb song_att_2,song_freq_102	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_77,song_freq_105	; c0
	fdb song_att_2,song_freq_100	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_78,song_freq_107	; c0
	fdb song_att_2,song_freq_102	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_108	; c0
	fdb song_att_2,song_freq_109	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_110	; c0
	fdb song_att_79,song_freq_111	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_108	; c0
	fdb song_att_2,song_freq_109	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_110	; c0
	fdb song_att_79,song_freq_112	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_2,song_freq_108	; c0
	fdb song_att_2,song_freq_113	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_2,song_freq_110	; c0
	fdb song_att_79,song_freq_114	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_2,song_freq_108	; c0
	fdb song_att_2,song_freq_113	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_2,song_freq_110	; c0
	fdb song_att_79,song_freq_115	; c1
	fdb song_att_5,song_freq_27	; c2

	fcb 96
	fdb song_att_20,song_freq_116	; c0
	fdb song_att_2,song_freq_109	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_117	; c0
	fdb song_att_79,song_freq_111	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_116	; c0
	fdb song_att_2,song_freq_109	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_117	; c0
	fdb song_att_79,song_freq_112	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_116	; c0
	fdb song_att_2,song_freq_113	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_20,song_freq_117	; c0
	fdb song_att_79,song_freq_114	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_20,song_freq_116	; c0
	fdb song_att_2,song_freq_113	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_40,song_freq_118	; c0
	fdb song_att_33,song_freq_33	; c1
	fdb song_att_5,song_freq_27	; c2

	fcb 96
	fdb song_att_41,song_freq_119	; c0
	fdb song_att_37,song_freq_120	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_42,song_freq_121	; c0
	fdb song_att_38,song_freq_122	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_43,song_freq_123	; c0
	fdb song_att_45,song_freq_124	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_44,song_freq_125	; c0
	fdb song_att_47,song_freq_126	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_46,song_freq_127	; c0
	fdb song_att_49,song_freq_128	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_48,song_freq_119	; c0
	fdb song_att_50,song_freq_129	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_130	; c0
	fdb song_att_80,song_freq_33	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_6	; c0
	fdb song_att_81,song_freq_120	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_82,song_freq_8	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_83,song_freq_8	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_84,song_freq_8	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_85,song_freq_8	; c0
	fdb song_att_86,song_freq_131	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_87,song_freq_8	; c0
	fdb song_att_32,song_freq_29	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_88,song_freq_16	; c0
	fdb song_att_2,song_freq_30	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_33,song_freq_24	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_20,song_freq_25	; c0
	fdb song_att_34,song_freq_31	; c1
	fdb song_att_5,song_freq_27	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_32,song_freq_29	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_16	; c0
	fdb song_att_2,song_freq_32	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_20,song_freq_19	; c0
	fdb song_att_33,song_freq_33	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_20,song_freq_132	; c0
	fdb song_att_35,song_freq_39	; c1
	fdb song_att_5,song_freq_133	; c2

	fcb 96
	fdb song_att_20,song_freq_134	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_6,song_freq_135	; c2

	fcb 96
	fdb song_att_20,song_freq_134	; c0
	fdb song_att_37,song_freq_12	; c1
	fdb song_att_5,song_freq_136	; c2

	fcb 96
	fdb song_att_20,song_freq_134	; c0
	fdb song_att_38,song_freq_13	; c1
	fdb song_att_4,song_freq_135	; c2

	fcb 96
	fdb song_att_20,song_freq_134	; c0
	fdb song_att_39,song_freq_137	; c1
	fdb song_att_5,song_freq_136	; c2

	fcb 96
	fdb song_att_20,song_freq_134	; c0
	fdb song_att_32,song_freq_138	; c1
	fdb song_att_6,song_freq_135	; c2

	fcb 96
	fdb song_att_20,song_freq_139	; c0
	fdb song_att_2,song_freq_140	; c1
	fdb song_att_5,song_freq_141	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_34,song_freq_142	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_32,song_freq_138	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_2,song_freq_143	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_20,song_freq_8	; c0
	fdb song_att_33,song_freq_144	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_40,song_freq_145	; c0
	fdb song_att_35,song_freq_146	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_41,song_freq_147	; c0
	fdb song_att_2,song_freq_148	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_42,song_freq_149	; c0
	fdb song_att_89,song_freq_150	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_43,song_freq_151	; c0
	fdb song_att_90,song_freq_152	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_44,song_freq_153	; c0
	fdb song_att_91,song_freq_154	; c1
	fdb song_att_5,song_freq_155	; c2

	fcb 96
	fdb song_att_46,song_freq_156	; c0
	fdb song_att_2,song_freq_157	; c1
	fdb song_att_6,song_freq_97	; c2

	fcb 96
	fdb song_att_48,song_freq_147	; c0
	fdb song_att_92,song_freq_158	; c1
	fdb song_att_5,song_freq_96	; c2

	fcb 96
	fdb song_att_2,song_freq_159	; c0
	fdb song_att_2,song_freq_157	; c1
	fdb song_att_4,song_freq_97	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_93,song_freq_160	; c1
	fdb song_att_5,song_freq_98	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_freq_161	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_93,song_freq_162	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_freq_148	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_92,song_freq_163	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_freq_148	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_89,song_freq_150	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_90,song_freq_152	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_91,song_freq_154	; c1
	fdb song_att_5,song_freq_155	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_freq_157	; c1
	fdb song_att_6,song_freq_97	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_92,song_freq_158	; c1
	fdb song_att_5,song_freq_96	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_freq_157	; c1
	fdb song_att_4,song_freq_97	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_93,song_freq_160	; c1
	fdb song_att_5,song_freq_98	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_freq_161	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_93,song_freq_162	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_2,song_freq_148	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_7,song_freq_6	; c0
	fdb song_att_89,song_freq_150	; c1
	fdb song_att_5,song_freq_164	; c2

	fcb 96
	fdb song_att_9,song_freq_66	; c0
	fdb song_att_94,song_freq_165	; c1
	fdb song_att_6,song_freq_166	; c2

	fcb 96
	fdb song_att_11,song_freq_167	; c0
	fdb song_att_2,song_freq_168	; c1
	fdb song_att_5,song_freq_169	; c2

	fcb 96
	fdb song_att_13,song_freq_170	; c0
	fdb song_att_2,song_freq_171	; c1
	fdb song_att_4,song_freq_166	; c2

	fcb 96
	fdb song_att_15,song_freq_172	; c0
	fdb song_att_2,song_freq_173	; c1
	fdb song_att_5,song_freq_174	; c2

	fcb 96
	fdb song_att_17,song_freq_175	; c0
	fdb song_att_23,song_freq_176	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_19,song_freq_177	; c0
	fdb song_att_95,song_freq_178	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_21,song_freq_179	; c0
	fdb song_att_23,song_freq_9	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_96,song_freq_66	; c0
	fdb song_att_24,song_freq_10	; c1
	fdb song_att_5,song_freq_180	; c2

	fcb 96
	fdb song_att_97,song_freq_167	; c0
	fdb song_att_98,song_freq_181	; c1
	fdb song_att_6,song_freq_61	; c2

	fcb 96
	fdb song_att_2,song_freq_182	; c0
	fdb song_att_2,song_freq_183	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_23,song_freq_49	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_99,song_freq_184	; c1
	fdb song_att_5,song_freq_185	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_23,song_freq_186	; c1
	fdb song_att_6,song_freq_97	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_99,song_freq_187	; c1
	fdb song_att_5,song_freq_96	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_32,song_freq_188	; c1
	fdb song_att_4,song_freq_97	; c2

	fcb 96
	fdb song_att_7,song_att_2	; c0
	fdb song_att_23,song_freq_56	; c1
	fdb song_att_5,song_freq_189	; c2

	fcb 96
	fdb song_att_9,song_freq_66	; c0
	fdb song_att_100,song_freq_190	; c1
	fdb song_att_6,song_freq_166	; c2

	fcb 96
	fdb song_att_11,song_freq_167	; c0
	fdb song_att_2,song_freq_168	; c1
	fdb song_att_5,song_freq_169	; c2

	fcb 96
	fdb song_att_13,song_freq_170	; c0
	fdb song_att_2,song_freq_171	; c1
	fdb song_att_4,song_freq_166	; c2

	fcb 96
	fdb song_att_15,song_freq_172	; c0
	fdb song_att_2,song_freq_173	; c1
	fdb song_att_5,song_freq_174	; c2

	fcb 96
	fdb song_att_17,song_freq_175	; c0
	fdb song_att_23,song_freq_176	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_19,song_freq_177	; c0
	fdb song_att_95,song_freq_178	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_21,song_freq_179	; c0
	fdb song_att_23,song_freq_9	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_96,song_freq_66	; c0
	fdb song_att_24,song_freq_10	; c1
	fdb song_att_5,song_freq_180	; c2

	fcb 96
	fdb song_att_97,song_freq_167	; c0
	fdb song_att_98,song_freq_181	; c1
	fdb song_att_6,song_freq_61	; c2

	fcb 96
	fdb song_att_2,song_freq_182	; c0
	fdb song_att_2,song_freq_183	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_23,song_freq_49	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_99,song_freq_184	; c1
	fdb song_att_5,song_freq_185	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_23,song_freq_186	; c1
	fdb song_att_6,song_freq_97	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_99,song_freq_187	; c1
	fdb song_att_5,song_freq_96	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_32,song_freq_188	; c1
	fdb song_att_4,song_freq_97	; c2

	fcb 96
	fdb song_att_7,song_att_2	; c0
	fdb song_att_23,song_freq_56	; c1
	fdb song_att_5,song_freq_98	; c2

	fcb 96
	fdb song_att_59,song_freq_191	; c0
	fdb song_att_24,song_freq_192	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_193	; c0
	fdb song_att_25,song_freq_194	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_195	; c0
	fdb song_att_27,song_freq_196	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_197	; c0
	fdb song_att_28,song_freq_198	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_191	; c0
	fdb song_att_29,song_freq_199	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_193	; c0
	fdb song_att_30,song_freq_200	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_freq_195	; c0
	fdb song_att_57,song_freq_56	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_freq_197	; c0
	fdb song_att_58,song_freq_192	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_2,song_freq_191	; c0
	fdb song_att_2,song_freq_201	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_2,song_freq_193	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_2,song_freq_195	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_2,song_freq_197	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_5,song_freq_59	; c2

	fcb 96
	fdb song_att_2,song_freq_191	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_6,song_freq_61	; c2

	fcb 96
	fdb song_att_2,song_freq_193	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_2,song_freq_195	; c0
	fdb song_att_2,song_att_2	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_101,song_freq_197	; c0
	fdb song_att_7,song_freq_7	; c1
	fdb song_att_5,song_freq_63	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_59,song_freq_203	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_103,song_freq_207	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_208	; c0
	fdb song_att_104,song_freq_209	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_2,song_freq_203	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_208	; c0
	fdb song_att_105,song_freq_210	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_2,song_freq_203	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_103,song_freq_207	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_102,song_freq_208	; c0
	fdb song_att_104,song_freq_209	; c1
	fdb song_att_5,song_freq_59	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_2,song_freq_203	; c1
	fdb song_att_6,song_freq_61	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_102,song_freq_208	; c0
	fdb song_att_105,song_freq_210	; c1
	fdb song_att_5,song_freq_63	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_2,song_freq_203	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_103,song_freq_207	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_208	; c0
	fdb song_att_104,song_freq_209	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_2,song_freq_203	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_102,song_freq_208	; c0
	fdb song_att_105,song_freq_210	; c1
	fdb song_att_5,song_freq_18	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_2,song_freq_203	; c1
	fdb song_att_6,song_freq_21	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_23	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_103,song_freq_207	; c1
	fdb song_att_4,song_freq_21	; c2

	fcb 96
	fdb song_att_102,song_freq_208	; c0
	fdb song_att_104,song_freq_209	; c1
	fdb song_att_5,song_freq_59	; c2

	fcb 96
	fdb song_att_102,song_freq_202	; c0
	fdb song_att_2,song_freq_203	; c1
	fdb song_att_6,song_freq_61	; c2

	fcb 96
	fdb song_att_102,song_freq_204	; c0
	fdb song_att_103,song_freq_205	; c1
	fdb song_att_5,song_freq_94	; c2

	fcb 96
	fdb song_att_102,song_freq_206	; c0
	fdb song_att_33,song_freq_11	; c1
	fdb song_att_4,song_freq_61	; c2

	fcb 96
	fdb song_att_106,song_freq_211	; c0
	fdb song_att_105,song_freq_212	; c1
	fdb song_att_5,song_freq_63	; c2

	fcb 96
	fdb song_att_107,song_att_2	; c0
	fdb song_att_32,song_freq_213	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_32,song_freq_214	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_23,song_freq_9	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_101,song_freq_215	; c0
	fdb song_att_54,song_freq_216	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_108,song_freq_217	; c0
	fdb song_att_32,song_freq_29	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_108,song_freq_6	; c0
	fdb song_att_32,song_freq_218	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_109,song_att_2	; c0
	fdb song_att_23,song_freq_9	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_24,song_freq_10	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_25,song_freq_11	; c1
	fdb song_att_6,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_27,song_freq_12	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_28,song_freq_13	; c1
	fdb song_att_4,song_freq_4	; c2

	fcb 96
	fdb song_att_2,song_att_2	; c0
	fdb song_att_29,song_freq_14	; c1
	fdb song_att_5,song_freq_5	; c2

	fcb 255		; end of song

; 62% reuse of attenuation patterns
; 23% reuse of frequency patterns

; Pattern data for attenuation and frequency.  Initial byte is delay to
; first note (so any note previously playing in the channel continues).
; Followed by (duration,data) pairs - data is 1 byte for attenuation, 3
; bytes for frequency.

song_att_0
	fcb 1		; t = 0ms (initial)
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

song_freq_0
	fcb 1		; t = 0ms (initial)
	fcb 255		; t = to end of pattern
	fcb $03,$81,$4c	; f = 123.8Hz

song_freq_1
	fcb 1		; t = 0ms (initial)
	fcb 255		; t = to end of pattern
	fcb $03,$82,$30	; f = 123.9Hz

song_att_1
	fcb 1		; t = 0ms (initial)
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 255		; t = to end of pattern
	fcb 68		; a = -2dB

song_freq_2
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 7		; t = 70ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_att_2
	fcb 255		; t = to end of pattern

song_att_3
	fcb 1		; t = 0ms (initial)
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 2		; t = 20ms
	fcb 17		; a = -14dB
	fcb 2		; t = 20ms
	fcb 13		; a = -16dB
	fcb 2		; t = 20ms
	fcb 11		; a = -18dB
	fcb 2		; t = 20ms
	fcb 9		; a = -20dB
	fcb 2		; t = 20ms
	fcb 7		; a = -22dB
	fcb 2		; t = 20ms
	fcb 5		; a = -24dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_3
	fcb 3		; t = 20ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_att_4
	fcb 6		; t = 50ms (initial)
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 54		; a = -4dB

song_freq_4
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_att_5
	fcb 1		; t = 0ms (initial)
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 2		; t = 20ms
	fcb 17		; a = -14dB
	fcb 2		; t = 20ms
	fcb 13		; a = -16dB
	fcb 2		; t = 20ms
	fcb 11		; a = -18dB
	fcb 2		; t = 20ms
	fcb 9		; a = -20dB
	fcb 2		; t = 20ms
	fcb 7		; a = -22dB
	fcb 2		; t = 20ms
	fcb 5		; a = -24dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_5
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_att_6
	fcb 6		; t = 50ms (initial)
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 54		; a = -4dB

song_freq_6
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_7
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_freq_7
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_8
	fcb 31		; t = 300ms (initial)
	fcb 38		; t = 380ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 4		; a = -26dB

song_freq_8
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 4		; t = 40ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 5		; t = 50ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 4		; t = 40ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 5		; t = 50ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 5		; t = 50ms
	fcb $07,$d9,$77	; f = 277.2Hz
	fcb 10		; t = 100ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 4		; t = 40ms
	fcb $07,$d9,$77	; f = 277.2Hz
	fcb 5		; t = 50ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 4		; t = 40ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_9
	fcb 4		; t = 30ms (initial)
	fcb 56		; t = 560ms
	fcb 85		; a = -0dB
	fcb 255		; t = to end of pattern
	fcb 68		; a = -2dB

song_freq_9
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_10
	fcb 12		; t = 110ms (initial)
	fcb 38		; t = 380ms
	fcb 5		; a = -24dB
	fcb 39		; t = 390ms
	fcb 7		; a = -22dB
	fcb 255		; t = to end of pattern
	fcb 9		; a = -20dB

song_att_11
	fcb 20		; t = 190ms (initial)
	fcb 56		; t = 560ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_freq_10
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_12
	fcb 31		; t = 300ms (initial)
	fcb 38		; t = 380ms
	fcb 11		; a = -18dB
	fcb 255		; t = to end of pattern
	fcb 13		; a = -16dB

song_att_13
	fcb 36		; t = 350ms (initial)
	fcb 56		; t = 560ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_freq_11
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_14
	fcb 12		; t = 110ms (initial)
	fcb 38		; t = 380ms
	fcb 17		; a = -14dB
	fcb 39		; t = 390ms
	fcb 21		; a = -12dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_att_15
	fcb 52		; t = 510ms (initial)
	fcb 255		; t = to end of pattern
	fcb 21		; a = -12dB

song_freq_12
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$81,$3a	; f = 370.9Hz

song_att_16
	fcb 31		; t = 300ms (initial)
	fcb 38		; t = 380ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_att_17
	fcb 12		; t = 110ms (initial)
	fcb 56		; t = 560ms
	fcb 17		; a = -14dB
	fcb 255		; t = to end of pattern
	fcb 13		; a = -16dB

song_freq_13
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_18
	fcb 12		; t = 110ms (initial)
	fcb 38		; t = 380ms
	fcb 54		; a = -4dB
	fcb 39		; t = 390ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_att_19
	fcb 28		; t = 270ms (initial)
	fcb 56		; t = 560ms
	fcb 11		; a = -18dB
	fcb 255		; t = to end of pattern
	fcb 9		; a = -20dB

song_freq_14
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$81,$3a	; f = 370.9Hz

song_att_20
	fcb 7		; t = 60ms (initial)
	fcb 24		; t = 240ms
	fcb 68		; a = -2dB
	fcb 24		; t = 240ms
	fcb 85		; a = -0dB
	fcb 24		; t = 240ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_att_21
	fcb 44		; t = 430ms (initial)
	fcb 255		; t = to end of pattern
	fcb 7		; a = -22dB

song_freq_15
	fcb 2		; t = 10ms (initial)
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_16
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 4		; t = 40ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 5		; t = 50ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 4		; t = 40ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 5		; t = 50ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 5		; t = 50ms
	fcb $07,$d9,$77	; f = 277.2Hz
	fcb 10		; t = 100ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 4		; t = 40ms
	fcb $07,$d9,$77	; f = 277.2Hz
	fcb 5		; t = 50ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 4		; t = 40ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 255		; t = to end of pattern
	fcb $04,$bd,$36	; f = 167.3Hz

song_att_22
	fcb 4		; t = 30ms (initial)
	fcb 56		; t = 560ms
	fcb 5		; a = -24dB
	fcb 9		; t = 90ms
	fcb 4		; a = -26dB
	fcb 7		; t = 70ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_17
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 2		; t = 20ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 10		; t = 100ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $09,$7d,$ad	; f = 335.1Hz

song_freq_18
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$2e,$17	; f = 41.7Hz

song_freq_19
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 4		; t = 40ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 5		; t = 50ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 5		; t = 50ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 255		; t = to end of pattern
	fcb $04,$bd,$36	; f = 167.3Hz

song_att_23
	fcb 53		; t = 520ms (initial)
	fcb 255		; t = to end of pattern
	fcb 68		; a = -2dB

song_freq_20
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 255		; t = to end of pattern
	fcb $09,$7d,$ad	; f = 335.1Hz

song_freq_21
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 255		; t = to end of pattern
	fcb $01,$2e,$17	; f = 41.7Hz

song_att_24
	fcb 13		; t = 120ms (initial)
	fcb 56		; t = 560ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_freq_22
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 255		; t = to end of pattern
	fcb $09,$7d,$ad	; f = 335.1Hz

song_freq_23
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 255		; t = to end of pattern
	fcb $01,$2e,$17	; f = 41.7Hz

song_att_25
	fcb 29		; t = 280ms (initial)
	fcb 56		; t = 560ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_freq_24
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 255		; t = to end of pattern
	fcb $09,$7d,$ad	; f = 335.1Hz

song_freq_25
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 4		; t = 40ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 5		; t = 50ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 5		; t = 50ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_26
	fcb 45		; t = 440ms (initial)
	fcb 48		; t = 480ms
	fcb 21		; a = -12dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_26
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 13		; t = 130ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_27
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_att_27
	fcb 45		; t = 440ms (initial)
	fcb 255		; t = to end of pattern
	fcb 21		; a = -12dB

song_att_28
	fcb 5		; t = 40ms (initial)
	fcb 56		; t = 560ms
	fcb 17		; a = -14dB
	fcb 255		; t = to end of pattern
	fcb 13		; a = -16dB

song_att_29
	fcb 21		; t = 200ms (initial)
	fcb 56		; t = 560ms
	fcb 11		; a = -18dB
	fcb 255		; t = to end of pattern
	fcb 9		; a = -20dB

song_att_30
	fcb 37		; t = 360ms (initial)
	fcb 56		; t = 560ms
	fcb 7		; a = -22dB
	fcb 255		; t = to end of pattern
	fcb 5		; a = -24dB

song_att_31
	fcb 53		; t = 520ms (initial)
	fcb 16		; t = 160ms
	fcb 4		; a = -26dB
	fcb 7		; t = 70ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_28
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 2		; t = 20ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_att_32
	fcb 53		; t = 520ms (initial)
	fcb 40		; t = 400ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_29
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_freq_30
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 13		; t = 130ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 255		; t = to end of pattern
	fcb $09,$7d,$ad	; f = 335.1Hz

song_att_33
	fcb 29		; t = 280ms (initial)
	fcb 56		; t = 560ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 54		; a = -4dB

song_att_34
	fcb 45		; t = 440ms (initial)
	fcb 24		; t = 240ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_31
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 10		; t = 100ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_32
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 13		; t = 130ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_33
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_34
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 4		; t = 40ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 5		; t = 50ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 5		; t = 50ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 11		; t = 110ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 4		; t = 40ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_35
	fcb 21		; t = 200ms (initial)
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_35
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 4		; t = 40ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 8		; t = 80ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_36
	fcb 1		; t = 0ms (initial)
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 2		; t = 20ms
	fcb 17		; a = -14dB
	fcb 2		; t = 20ms
	fcb 13		; a = -16dB
	fcb 2		; t = 20ms
	fcb 11		; a = -18dB
	fcb 2		; t = 20ms
	fcb 9		; a = -20dB
	fcb 2		; t = 20ms
	fcb 7		; a = -22dB
	fcb 2		; t = 20ms
	fcb 5		; a = -24dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 9		; t = 90ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_36
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 9		; t = 90ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_att_37
	fcb 45		; t = 440ms (initial)
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_att_38
	fcb 5		; t = 40ms (initial)
	fcb 56		; t = 560ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_att_39
	fcb 21		; t = 200ms (initial)
	fcb 48		; t = 480ms
	fcb 21		; a = -12dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_37
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 20		; t = 200ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_att_40
	fcb 7		; t = 60ms (initial)
	fcb 24		; t = 240ms
	fcb 68		; a = -2dB
	fcb 24		; t = 240ms
	fcb 85		; a = -0dB
	fcb 24		; t = 240ms
	fcb 68		; a = -2dB
	fcb 15		; t = 150ms
	fcb 85		; a = -0dB
	fcb 255		; t = to end of pattern
	fcb 68		; a = -2dB

song_freq_38
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 4		; t = 40ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 5		; t = 50ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 5		; t = 50ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_39
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 4		; t = 40ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_41
	fcb 38		; t = 370ms (initial)
	fcb 40		; t = 400ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_freq_40
	fcb 8		; t = 70ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_42
	fcb 22		; t = 210ms (initial)
	fcb 40		; t = 400ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_freq_41
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$40,$9d	; f = 185.5Hz

song_att_43
	fcb 6		; t = 50ms (initial)
	fcb 40		; t = 400ms
	fcb 21		; a = -12dB
	fcb 40		; t = 400ms
	fcb 17		; a = -14dB
	fcb 255		; t = to end of pattern
	fcb 13		; a = -16dB

song_freq_42
	fcb 1		; t = 0ms (initial)
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_44
	fcb 30		; t = 290ms (initial)
	fcb 40		; t = 400ms
	fcb 11		; a = -18dB
	fcb 255		; t = to end of pattern
	fcb 9		; a = -20dB

song_freq_43
	fcb 5		; t = 40ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$40,$9d	; f = 185.5Hz

song_att_45
	fcb 21		; t = 200ms (initial)
	fcb 56		; t = 560ms
	fcb 21		; a = -12dB
	fcb 255		; t = to end of pattern
	fcb 17		; a = -14dB

song_att_46
	fcb 14		; t = 130ms (initial)
	fcb 40		; t = 400ms
	fcb 7		; a = -22dB
	fcb 40		; t = 400ms
	fcb 5		; a = -24dB
	fcb 255		; t = to end of pattern
	fcb 4		; a = -26dB

song_freq_44
	fcb 4		; t = 30ms (initial)
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_47
	fcb 37		; t = 360ms (initial)
	fcb 56		; t = 560ms
	fcb 13		; a = -16dB
	fcb 255		; t = to end of pattern
	fcb 11		; a = -18dB

song_att_48
	fcb 38		; t = 370ms (initial)
	fcb 40		; t = 400ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

song_att_49
	fcb 53		; t = 520ms (initial)
	fcb 255		; t = to end of pattern
	fcb 9		; a = -20dB

song_freq_45
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$40,$9d	; f = 185.5Hz

song_att_50
	fcb 13		; t = 120ms (initial)
	fcb 56		; t = 560ms
	fcb 7		; a = -22dB
	fcb 255		; t = to end of pattern
	fcb 5		; a = -24dB

song_freq_46
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $03,$fc,$93	; f = 140.8Hz

song_att_51
	fcb 29		; t = 280ms (initial)
	fcb 56		; t = 560ms
	fcb 4		; a = -26dB
	fcb 8		; t = 80ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 34		; a = -8dB

song_freq_47
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 1		; t = 10ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_att_52
	fcb 27		; t = 260ms (initial)
	fcb 15		; t = 150ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

song_freq_48
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 10		; t = 100ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 5		; t = 50ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 10		; t = 100ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 5		; t = 50ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 10		; t = 100ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 5		; t = 50ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 10		; t = 100ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 5		; t = 50ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 10		; t = 100ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 255		; t = to end of pattern
	fcb $03,$ee,$f7	; f = 138.9Hz

song_freq_49
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_att_53
	fcb 20		; t = 190ms (initial)
	fcb 56		; t = 560ms
	fcb 54		; a = -4dB
	fcb 17		; t = 170ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_50
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 10		; t = 100ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 255		; t = to end of pattern
	fcb $06,$58,$23	; f = 224.0Hz

song_freq_51
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$40,$9d	; f = 185.5Hz

song_freq_52
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 255		; t = to end of pattern
	fcb $06,$58,$23	; f = 224.0Hz

song_freq_53
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $04,$bd,$36	; f = 167.3Hz

song_att_54
	fcb 13		; t = 120ms (initial)
	fcb 56		; t = 560ms
	fcb 54		; a = -4dB
	fcb 24		; t = 240ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_54
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 10		; t = 100ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$fa,$dc	; f = 211.1Hz

song_freq_55
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 255		; t = to end of pattern
	fcb $04,$ad,$2f	; f = 165.1Hz

song_freq_56
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$fa,$dc	; f = 211.1Hz

song_freq_57
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $04,$3a,$c2	; f = 149.3Hz

song_freq_58
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 10		; t = 100ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_freq_59
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 255		; t = to end of pattern
	fcb $01,$0d,$b9	; f = 37.2Hz

song_freq_60
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 10		; t = 100ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 5		; t = 50ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 10		; t = 100ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 5		; t = 50ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 10		; t = 100ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 5		; t = 50ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 10		; t = 100ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 5		; t = 50ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 10		; t = 100ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 255		; t = to end of pattern
	fcb $04,$2b,$75	; f = 147.2Hz

song_freq_61
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 4		; t = 40ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 255		; t = to end of pattern
	fcb $01,$0d,$b9	; f = 37.2Hz

song_freq_62
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_freq_63
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 4		; t = 40ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_freq_64
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 14		; t = 140ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 14		; t = 140ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 14		; t = 140ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 14		; t = 140ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 255		; t = to end of pattern
	fcb $03,$fc,$93	; f = 140.8Hz

song_freq_65
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 14		; t = 140ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 14		; t = 140ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 14		; t = 140ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 7		; t = 70ms
	fcb $03,$ee,$f7	; f = 138.9Hz
	fcb 10		; t = 100ms
	fcb $03,$fc,$93	; f = 140.8Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_66
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_67
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $04,$bd,$36	; f = 167.3Hz

song_freq_68
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 14		; t = 140ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 14		; t = 140ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 14		; t = 140ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 14		; t = 140ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 255		; t = to end of pattern
	fcb $04,$bd,$36	; f = 167.3Hz

song_freq_69
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 14		; t = 140ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 14		; t = 140ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 14		; t = 140ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 255		; t = to end of pattern
	fcb $04,$3a,$c2	; f = 149.3Hz

song_freq_70
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 255		; t = to end of pattern
	fcb $04,$3a,$c2	; f = 149.3Hz

song_freq_71
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 255		; t = to end of pattern
	fcb $04,$3a,$c2	; f = 149.3Hz

song_freq_72
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 255		; t = to end of pattern
	fcb $04,$3a,$c2	; f = 149.3Hz

song_freq_73
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_freq_74
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 255		; t = to end of pattern
	fcb $04,$2b,$75	; f = 147.2Hz

song_freq_75
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$42,$9c	; f = 185.7Hz

song_freq_76
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 255		; t = to end of pattern
	fcb $04,$3a,$c2	; f = 149.3Hz

song_freq_77
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_freq_78
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 255		; t = to end of pattern
	fcb $04,$2b,$75	; f = 147.2Hz

song_freq_79
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$42,$9c	; f = 185.7Hz

song_att_55
	fcb 38		; t = 370ms (initial)
	fcb 56		; t = 560ms
	fcb 7		; a = -22dB
	fcb 255		; t = to end of pattern
	fcb 5		; a = -24dB

song_freq_80
	fcb 2		; t = 10ms (initial)
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 15		; t = 150ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 255		; t = to end of pattern
	fcb $04,$3a,$c2	; f = 149.3Hz

song_freq_81
	fcb 2		; t = 10ms (initial)
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 15		; t = 150ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_att_56
	fcb 6		; t = 50ms (initial)
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 9		; t = 90ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 2		; t = 20ms
	fcb 54		; a = -4dB
	fcb 2		; t = 20ms
	fcb 43		; a = -6dB
	fcb 2		; t = 20ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 3		; t = 30ms
	fcb 68		; a = -2dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 5		; t = 50ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 54		; a = -4dB

song_freq_82
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 9		; t = 90ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_att_57
	fcb 53		; t = 520ms (initial)
	fcb 255		; t = to end of pattern
	fcb 4		; a = -26dB

song_att_58
	fcb 13		; t = 120ms (initial)
	fcb 56		; t = 560ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

song_freq_83
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$2b,$75	; f = 147.2Hz
	fcb 14		; t = 140ms
	fcb $04,$3a,$c2	; f = 149.3Hz
	fcb 255		; t = to end of pattern
	fcb $04,$2b,$75	; f = 147.2Hz

song_freq_84
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 71		; t = 710ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_85
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $0c,$a4,$ad	; f = 446.4Hz

song_att_59
	fcb 4		; t = 30ms (initial)
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_86
	fcb 4		; t = 30ms (initial)
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 5		; t = 50ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_60
	fcb 21		; t = 200ms (initial)
	fcb 34		; t = 340ms
	fcb 3		; a = -28dB
	fcb 31		; t = 310ms
	fcb 4		; a = -26dB
	fcb 255		; t = to end of pattern
	fcb 5		; a = -24dB

song_freq_87
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 2		; t = 20ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 2		; t = 20ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 2		; t = 20ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 2		; t = 20ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 2		; t = 20ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 2		; t = 20ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 2		; t = 20ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $09,$77,$2e	; f = 334.2Hz
	fcb 5		; t = 50ms
	fcb $09,$57,$36	; f = 329.8Hz
	fcb 2		; t = 20ms
	fcb $09,$77,$2e	; f = 334.2Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a1,$88	; f = 375.4Hz

song_freq_88
	fcb 4		; t = 30ms (initial)
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 5		; t = 50ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $08,$78,$1c	; f = 299.0Hz
	fcb 5		; t = 50ms
	fcb $08,$59,$6e	; f = 294.8Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 5		; t = 50ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 7		; t = 70ms
	fcb $08,$78,$1c	; f = 299.0Hz
	fcb 5		; t = 50ms
	fcb $08,$59,$6e	; f = 294.8Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_att_61
	fcb 21		; t = 200ms (initial)
	fcb 34		; t = 340ms
	fcb 7		; a = -22dB
	fcb 31		; t = 310ms
	fcb 9		; a = -20dB
	fcb 255		; t = to end of pattern
	fcb 11		; a = -18dB

song_freq_89
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 2		; t = 20ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $09,$77,$2e	; f = 334.2Hz
	fcb 5		; t = 50ms
	fcb $09,$57,$36	; f = 329.8Hz
	fcb 2		; t = 20ms
	fcb $09,$77,$2e	; f = 334.2Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 2		; t = 20ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 5		; t = 50ms
	fcb $08,$54,$66	; f = 294.1Hz
	fcb 2		; t = 20ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 5		; t = 50ms
	fcb $09,$77,$2e	; f = 334.2Hz
	fcb 5		; t = 50ms
	fcb $09,$57,$36	; f = 329.8Hz
	fcb 2		; t = 20ms
	fcb $09,$77,$2e	; f = 334.2Hz
	fcb 5		; t = 50ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 5		; t = 50ms
	fcb $08,$54,$66	; f = 294.1Hz
	fcb 2		; t = 20ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 2		; t = 20ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 2		; t = 20ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$a4,$ad	; f = 446.4Hz

song_freq_90
	fcb 4		; t = 30ms (initial)
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_att_62
	fcb 21		; t = 200ms (initial)
	fcb 34		; t = 340ms
	fcb 13		; a = -16dB
	fcb 31		; t = 310ms
	fcb 17		; a = -14dB
	fcb 255		; t = to end of pattern
	fcb 21		; a = -12dB

song_freq_91
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 2		; t = 20ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 2		; t = 20ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 2		; t = 20ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 2		; t = 20ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 2		; t = 20ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 2		; t = 20ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 2		; t = 20ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$29,$14	; f = 500.0Hz

song_att_63
	fcb 41		; t = 400ms (initial)
	fcb 52		; t = 520ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_92
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_att_64
	fcb 55		; t = 540ms (initial)
	fcb 255		; t = to end of pattern
	fcb 17		; a = -14dB

song_freq_93
	fcb 5		; t = 40ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 8		; t = 80ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$a4,$ad	; f = 446.4Hz

song_att_65
	fcb 26		; t = 250ms (initial)
	fcb 31		; t = 310ms
	fcb 21		; a = -12dB
	fcb 34		; t = 340ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 34		; a = -8dB

song_att_66
	fcb 26		; t = 250ms (initial)
	fcb 31		; t = 310ms
	fcb 43		; a = -6dB
	fcb 34		; t = 340ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 68		; a = -2dB

song_att_67
	fcb 26		; t = 250ms (initial)
	fcb 17		; t = 170ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 255		; t = to end of pattern
	fcb 68		; a = -2dB

song_att_68
	fcb 35		; t = 340ms (initial)
	fcb 40		; t = 400ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_att_69
	fcb 9		; t = 80ms (initial)
	fcb 34		; t = 340ms
	fcb 54		; a = -4dB
	fcb 31		; t = 310ms
	fcb 68		; a = -2dB
	fcb 17		; t = 170ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_94
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 4		; t = 40ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 255		; t = to end of pattern
	fcb $01,$0d,$b9	; f = 37.2Hz

song_att_70
	fcb 19		; t = 180ms (initial)
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_att_71
	fcb 19		; t = 180ms (initial)
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 2		; t = 20ms
	fcb 68		; a = -2dB
	fcb 22		; t = 220ms
	fcb 85		; a = -0dB
	fcb 255		; t = to end of pattern
	fcb 68		; a = -2dB

song_freq_95
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 4		; t = 40ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 255		; t = to end of pattern
	fcb $00,$fe,$ee	; f = 35.2Hz

song_freq_96
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 255		; t = to end of pattern
	fcb $00,$fe,$ee	; f = 35.2Hz

song_freq_97
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 255		; t = to end of pattern
	fcb $00,$fe,$ee	; f = 35.2Hz

song_freq_98
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_freq_99
	fcb 5		; t = 40ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 255		; t = to end of pattern
	fcb $0d,$ef,$fd	; f = 492.1Hz

song_freq_100
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 10		; t = 100ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_att_72
	fcb 19		; t = 180ms (initial)
	fcb 40		; t = 400ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_freq_101
	fcb 4		; t = 30ms (initial)
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$29,$14	; f = 500.0Hz

song_freq_102
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 10		; t = 100ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 10		; t = 100ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_att_73
	fcb 3		; t = 20ms (initial)
	fcb 40		; t = 400ms
	fcb 21		; a = -12dB
	fcb 40		; t = 400ms
	fcb 17		; a = -14dB
	fcb 255		; t = to end of pattern
	fcb 13		; a = -16dB

song_freq_103
	fcb 8		; t = 70ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$29,$14	; f = 500.0Hz

song_att_74
	fcb 27		; t = 260ms (initial)
	fcb 40		; t = 400ms
	fcb 11		; a = -18dB
	fcb 255		; t = to end of pattern
	fcb 9		; a = -20dB

song_freq_104
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 1		; t = 10ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$df,$fd	; f = 560.5Hz

song_att_75
	fcb 21		; t = 200ms (initial)
	fcb 39		; t = 390ms
	fcb 11		; a = -18dB
	fcb 255		; t = to end of pattern
	fcb 13		; a = -16dB

song_freq_105
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0f,$aa,$0b	; f = 553.1Hz
	fcb 10		; t = 100ms
	fcb $0f,$df,$fd	; f = 560.5Hz
	fcb 4		; t = 40ms
	fcb $0f,$aa,$0b	; f = 553.1Hz
	fcb 5		; t = 50ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 4		; t = 40ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 5		; t = 50ms
	fcb $0f,$df,$fd	; f = 560.5Hz
	fcb 5		; t = 50ms
	fcb $0f,$aa,$0b	; f = 553.1Hz
	fcb 10		; t = 100ms
	fcb $0f,$df,$fd	; f = 560.5Hz
	fcb 4		; t = 40ms
	fcb $0f,$aa,$0b	; f = 553.1Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 4		; t = 40ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$29,$14	; f = 500.0Hz

song_att_76
	fcb 2		; t = 10ms (initial)
	fcb 39		; t = 390ms
	fcb 17		; a = -14dB
	fcb 38		; t = 380ms
	fcb 21		; a = -12dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_freq_106
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 4		; t = 40ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 4		; t = 40ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 5		; t = 50ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 4		; t = 40ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 4		; t = 40ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$df,$fd	; f = 560.5Hz

song_att_77
	fcb 21		; t = 200ms (initial)
	fcb 39		; t = 390ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_att_78
	fcb 2		; t = 10ms (initial)
	fcb 39		; t = 390ms
	fcb 54		; a = -4dB
	fcb 38		; t = 380ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_107
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 4		; t = 40ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 4		; t = 40ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 5		; t = 50ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 4		; t = 40ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 4		; t = 40ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$eb,$69	; f = 420.9Hz

song_freq_108
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 7		; t = 70ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 7		; t = 70ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 7		; t = 70ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 7		; t = 70ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 7		; t = 70ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$29,$14	; f = 500.0Hz

song_freq_109
	fcb 4		; t = 30ms (initial)
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$f2,$4b	; f = 563.1Hz

song_freq_110
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 7		; t = 70ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 7		; t = 70ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 7		; t = 70ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 7		; t = 70ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$eb,$69	; f = 420.9Hz

song_att_79
	fcb 29		; t = 280ms (initial)
	fcb 56		; t = 560ms
	fcb 68		; a = -2dB
	fcb 8		; t = 80ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_111
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 1		; t = 10ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_112
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 1		; t = 10ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_freq_113
	fcb 4		; t = 30ms (initial)
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_114
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 1		; t = 10ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_freq_115
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 1		; t = 10ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_116
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 4		; t = 40ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 4		; t = 40ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 4		; t = 40ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 4		; t = 40ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$29,$14	; f = 500.0Hz

song_freq_117
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 4		; t = 40ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 4		; t = 40ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 4		; t = 40ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 4		; t = 40ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$eb,$69	; f = 420.9Hz

song_freq_118
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$29,$14	; f = 500.0Hz
	fcb 4		; t = 40ms
	fcb $0d,$ef,$fd	; f = 492.1Hz
	fcb 5		; t = 50ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 5		; t = 50ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 10		; t = 100ms
	fcb $0c,$a4,$ad	; f = 446.4Hz
	fcb 4		; t = 40ms
	fcb $0c,$77,$17	; f = 440.1Hz
	fcb 5		; t = 50ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 5		; t = 50ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 10		; t = 100ms
	fcb $0b,$eb,$69	; f = 420.9Hz
	fcb 4		; t = 40ms
	fcb $0b,$c2,$dd	; f = 415.3Hz
	fcb 5		; t = 50ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a1,$88	; f = 375.4Hz

song_freq_119
	fcb 8		; t = 70ms (initial)
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a1,$88	; f = 375.4Hz

song_freq_120
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 255		; t = to end of pattern
	fcb $0d,$fe,$18	; f = 494.1Hz

song_freq_121
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$79,$45	; f = 369.8Hz

song_freq_122
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_123
	fcb 1		; t = 0ms (initial)
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a1,$88	; f = 375.4Hz

song_freq_124
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 255		; t = to end of pattern
	fcb $0d,$fe,$18	; f = 494.1Hz

song_freq_125
	fcb 5		; t = 40ms (initial)
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$79,$45	; f = 369.8Hz

song_freq_126
	fcb 2		; t = 10ms (initial)
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_127
	fcb 4		; t = 30ms (initial)
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a1,$88	; f = 375.4Hz

song_freq_128
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_129
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_130
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $0a,$79,$45	; f = 369.8Hz
	fcb 10		; t = 100ms
	fcb $0a,$a1,$88	; f = 375.4Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$79,$45	; f = 369.8Hz

song_att_80
	fcb 29		; t = 280ms (initial)
	fcb 56		; t = 560ms
	fcb 4		; a = -26dB
	fcb 255		; t = to end of pattern
	fcb 3		; a = -28dB

song_att_81
	fcb 45		; t = 440ms (initial)
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

song_att_82
	fcb 26		; t = 250ms (initial)
	fcb 39		; t = 390ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 4		; a = -26dB

song_att_83
	fcb 7		; t = 60ms (initial)
	fcb 38		; t = 380ms
	fcb 5		; a = -24dB
	fcb 39		; t = 390ms
	fcb 7		; a = -22dB
	fcb 255		; t = to end of pattern
	fcb 9		; a = -20dB

song_att_84
	fcb 26		; t = 250ms (initial)
	fcb 39		; t = 390ms
	fcb 11		; a = -18dB
	fcb 255		; t = to end of pattern
	fcb 13		; a = -16dB

song_att_85
	fcb 7		; t = 60ms (initial)
	fcb 38		; t = 380ms
	fcb 17		; a = -14dB
	fcb 39		; t = 390ms
	fcb 21		; a = -12dB
	fcb 255		; t = to end of pattern
	fcb 27		; a = -10dB

song_att_86
	fcb 69		; t = 680ms (initial)
	fcb 7		; t = 70ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_131
	fcb 69		; t = 680ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 5		; t = 50ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_att_87
	fcb 26		; t = 250ms (initial)
	fcb 39		; t = 390ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_att_88
	fcb 7		; t = 60ms (initial)
	fcb 38		; t = 380ms
	fcb 54		; a = -4dB
	fcb 39		; t = 390ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_132
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 4		; t = 40ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 5		; t = 50ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 5		; t = 50ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 4		; t = 40ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$f8,$47	; f = 210.8Hz

song_freq_133
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 255		; t = to end of pattern
	fcb $01,$7e,$64	; f = 52.7Hz

song_freq_134
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 5		; t = 50ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 5		; t = 50ms
	fcb $08,$54,$66	; f = 294.1Hz
	fcb 10		; t = 100ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 4		; t = 40ms
	fcb $08,$54,$66	; f = 294.1Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$f8,$47	; f = 210.8Hz

song_freq_135
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 4		; t = 40ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 8		; t = 80ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 4		; t = 40ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 255		; t = to end of pattern
	fcb $01,$7e,$64	; f = 52.7Hz

song_freq_136
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 4		; t = 40ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 8		; t = 80ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 8		; t = 80ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 8		; t = 80ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 4		; t = 40ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 255		; t = to end of pattern
	fcb $01,$7e,$64	; f = 52.7Hz

song_freq_137
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 13		; t = 130ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_138
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_139
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 4		; t = 40ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 5		; t = 50ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 5		; t = 50ms
	fcb $08,$54,$66	; f = 294.1Hz
	fcb 10		; t = 100ms
	fcb $08,$72,$ef	; f = 298.3Hz
	fcb 4		; t = 40ms
	fcb $08,$54,$66	; f = 294.1Hz
	fcb 5		; t = 50ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 5		; t = 50ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 4		; t = 40ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_140
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 13		; t = 130ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_141
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 8		; t = 80ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $01,$77,$44	; f = 51.8Hz
	fcb 4		; t = 40ms
	fcb $01,$7e,$64	; f = 52.7Hz
	fcb 4		; t = 40ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 8		; t = 80ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 8		; t = 80ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 8		; t = 80ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 4		; t = 40ms
	fcb $02,$f3,$39	; f = 104.2Hz
	fcb 4		; t = 40ms
	fcb $02,$fc,$c9	; f = 105.5Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_freq_142
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 10		; t = 100ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 255		; t = to end of pattern
	fcb $0e,$37,$a3	; f = 502.0Hz

song_freq_143
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 13		; t = 130ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$f2,$4b	; f = 563.1Hz

song_freq_144
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$f2,$4b	; f = 563.1Hz

song_freq_145
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 4		; t = 40ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 5		; t = 50ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 4		; t = 40ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 5		; t = 50ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 5		; t = 50ms
	fcb $07,$d9,$77	; f = 277.2Hz
	fcb 10		; t = 100ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 4		; t = 40ms
	fcb $07,$d9,$77	; f = 277.2Hz
	fcb 5		; t = 50ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 255		; t = to end of pattern
	fcb $06,$55,$3c	; f = 223.6Hz

song_freq_146
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 4		; t = 40ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 10		; t = 100ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_147
	fcb 8		; t = 70ms (initial)
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 255		; t = to end of pattern
	fcb $06,$55,$3c	; f = 223.6Hz

song_freq_148
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 10		; t = 100ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$bb,$dd	; f = 555.6Hz

song_freq_149
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 255		; t = to end of pattern
	fcb $06,$3e,$5c	; f = 220.5Hz

song_att_89
	fcb 5		; t = 40ms (initial)
	fcb 56		; t = 560ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 54		; a = -4dB

song_freq_150
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$f2,$4b	; f = 563.1Hz

song_freq_151
	fcb 1		; t = 0ms (initial)
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 255		; t = to end of pattern
	fcb $06,$55,$3c	; f = 223.6Hz

song_att_90
	fcb 21		; t = 200ms (initial)
	fcb 56		; t = 560ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 34		; a = -8dB

song_freq_152
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 255		; t = to end of pattern
	fcb $0f,$bb,$dd	; f = 555.6Hz

song_freq_153
	fcb 5		; t = 40ms (initial)
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 255		; t = to end of pattern
	fcb $06,$3e,$5c	; f = 220.5Hz

song_att_91
	fcb 37		; t = 360ms (initial)
	fcb 56		; t = 560ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_154
	fcb 2		; t = 10ms (initial)
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 7		; t = 70ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_155
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 8		; t = 80ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $01,$2b,$19	; f = 41.3Hz
	fcb 4		; t = 40ms
	fcb $01,$2e,$17	; f = 41.7Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 8		; t = 80ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 4		; t = 40ms
	fcb $02,$56,$33	; f = 82.5Hz
	fcb 4		; t = 40ms
	fcb $02,$5c,$2e	; f = 83.3Hz
	fcb 255		; t = to end of pattern
	fcb $00,$fe,$ee	; f = 35.2Hz

song_freq_156
	fcb 4		; t = 30ms (initial)
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 255		; t = to end of pattern
	fcb $06,$55,$3c	; f = 223.6Hz

song_freq_157
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 10		; t = 100ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$82,$5e	; f = 441.7Hz

song_att_92
	fcb 5		; t = 40ms (initial)
	fcb 56		; t = 560ms
	fcb 68		; a = -2dB
	fcb 32		; t = 320ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_158
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 4		; t = 40ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_159
	fcb 2		; t = 10ms (initial)
	fcb 5		; t = 50ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 255		; t = to end of pattern
	fcb $06,$3e,$5c	; f = 220.5Hz

song_att_93
	fcb 5		; t = 40ms (initial)
	fcb 40		; t = 400ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_160
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 13		; t = 130ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_freq_161
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 10		; t = 100ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 255		; t = to end of pattern
	fcb $0d,$fe,$18	; f = 494.1Hz

song_freq_162
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 7		; t = 70ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 14		; t = 140ms
	fcb $0e,$37,$a3	; f = 502.0Hz
	fcb 5		; t = 50ms
	fcb $0d,$fe,$18	; f = 494.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 13		; t = 130ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_163
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 4		; t = 40ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_164
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$95,$7d	; f = 55.9Hz

song_att_94
	fcb 21		; t = 200ms (initial)
	fcb 24		; t = 240ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_165
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 14		; t = 140ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $0f,$bb,$dd	; f = 555.6Hz
	fcb 10		; t = 100ms
	fcb $0f,$f2,$4b	; f = 563.1Hz
	fcb 7		; t = 70ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 13		; t = 130ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 255		; t = to end of pattern
	fcb $07,$f9,$26	; f = 281.5Hz

song_freq_166
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 4		; t = 40ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 8		; t = 80ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 4		; t = 40ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 255		; t = to end of pattern
	fcb $01,$95,$7d	; f = 55.9Hz

song_freq_167
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_168
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $07,$dd,$ef	; f = 277.8Hz
	fcb 14		; t = 140ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 7		; t = 70ms
	fcb $07,$dd,$ef	; f = 277.8Hz
	fcb 13		; t = 130ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 7		; t = 70ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 13		; t = 130ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 255		; t = to end of pattern
	fcb $09,$7d,$ad	; f = 335.1Hz

song_freq_169
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 4		; t = 40ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 8		; t = 80ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 8		; t = 80ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 8		; t = 80ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 4		; t = 40ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$95,$7d	; f = 55.9Hz

song_freq_170
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_171
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 13		; t = 130ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 7		; t = 70ms
	fcb $07,$dd,$ef	; f = 277.8Hz
	fcb 14		; t = 140ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 7		; t = 70ms
	fcb $07,$dd,$ef	; f = 277.8Hz
	fcb 13		; t = 130ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_172
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$40,$9d	; f = 185.5Hz

song_freq_173
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 13		; t = 130ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 13		; t = 130ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_freq_174
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 8		; t = 80ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $01,$8d,$7d	; f = 54.8Hz
	fcb 4		; t = 40ms
	fcb $01,$95,$7d	; f = 55.9Hz
	fcb 4		; t = 40ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 8		; t = 80ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 8		; t = 80ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 8		; t = 80ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 4		; t = 40ms
	fcb $03,$1a,$f9	; f = 109.6Hz
	fcb 4		; t = 40ms
	fcb $03,$30,$75	; f = 112.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$53,$6d	; f = 46.8Hz

song_freq_175
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_176
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_freq_177
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $05,$40,$9d	; f = 185.5Hz

song_att_95
	fcb 13		; t = 120ms (initial)
	fcb 56		; t = 560ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_178
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_179
	fcb 2		; t = 10ms (initial)
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_96
	fcb 4		; t = 30ms (initial)
	fcb 56		; t = 560ms
	fcb 5		; a = -24dB
	fcb 255		; t = to end of pattern
	fcb 4		; a = -26dB

song_freq_180
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 8		; t = 80ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $01,$4d,$cd	; f = 46.0Hz
	fcb 4		; t = 40ms
	fcb $01,$53,$6d	; f = 46.8Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 8		; t = 80ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 4		; t = 40ms
	fcb $02,$9f,$50	; f = 92.6Hz
	fcb 4		; t = 40ms
	fcb $02,$a6,$da	; f = 93.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$0d,$b9	; f = 37.2Hz

song_att_97
	fcb 20		; t = 190ms (initial)
	fcb 56		; t = 560ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

song_att_98
	fcb 29		; t = 280ms (initial)
	fcb 16		; t = 160ms
	fcb 34		; a = -8dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_181
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 2		; t = 20ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 7		; t = 70ms
	fcb $04,$2c,$b7	; f = 147.4Hz
	fcb 14		; t = 140ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 7		; t = 70ms
	fcb $04,$2c,$b7	; f = 147.4Hz
	fcb 13		; t = 130ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 255		; t = to end of pattern
	fcb $04,$be,$d7	; f = 167.6Hz

song_freq_182
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 14		; t = 140ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_183
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $04,$ae,$c5	; f = 165.3Hz
	fcb 14		; t = 140ms
	fcb $04,$be,$d7	; f = 167.6Hz
	fcb 7		; t = 70ms
	fcb $04,$ae,$c5	; f = 165.3Hz
	fcb 13		; t = 130ms
	fcb $04,$be,$d7	; f = 167.6Hz
	fcb 7		; t = 70ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 7		; t = 70ms
	fcb $04,$2c,$b7	; f = 147.4Hz
	fcb 14		; t = 140ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 7		; t = 70ms
	fcb $04,$2c,$b7	; f = 147.4Hz
	fcb 13		; t = 130ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_att_99
	fcb 13		; t = 120ms (initial)
	fcb 8		; t = 80ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_184
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 8		; t = 80ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 10		; t = 100ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $04,$be,$d7	; f = 167.6Hz
	fcb 7		; t = 70ms
	fcb $04,$ae,$c5	; f = 165.3Hz
	fcb 10		; t = 100ms
	fcb $04,$be,$d7	; f = 167.6Hz
	fcb 7		; t = 70ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 7		; t = 70ms
	fcb $04,$2c,$b7	; f = 147.4Hz
	fcb 10		; t = 100ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 255		; t = to end of pattern
	fcb $03,$fd,$b9	; f = 140.9Hz

song_freq_185
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 8		; t = 80ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $01,$08,$fe	; f = 36.5Hz
	fcb 4		; t = 40ms
	fcb $01,$0d,$b9	; f = 37.2Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 8		; t = 80ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 4		; t = 40ms
	fcb $02,$11,$fb	; f = 73.1Hz
	fcb 4		; t = 40ms
	fcb $02,$1b,$72	; f = 74.4Hz
	fcb 255		; t = to end of pattern
	fcb $00,$fe,$ee	; f = 35.2Hz

song_freq_186
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $03,$f0,$16	; f = 139.0Hz
	fcb 14		; t = 140ms
	fcb $03,$fd,$b9	; f = 140.9Hz
	fcb 7		; t = 70ms
	fcb $03,$f0,$16	; f = 139.0Hz
	fcb 14		; t = 140ms
	fcb $03,$fd,$b9	; f = 140.9Hz
	fcb 7		; t = 70ms
	fcb $03,$f0,$16	; f = 139.0Hz
	fcb 14		; t = 140ms
	fcb $03,$fd,$b9	; f = 140.9Hz
	fcb 7		; t = 70ms
	fcb $03,$f0,$16	; f = 139.0Hz
	fcb 14		; t = 140ms
	fcb $03,$fd,$b9	; f = 140.9Hz
	fcb 7		; t = 70ms
	fcb $03,$f0,$16	; f = 139.0Hz
	fcb 255		; t = to end of pattern
	fcb $03,$fd,$b9	; f = 140.9Hz

song_freq_187
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $03,$f0,$16	; f = 139.0Hz
	fcb 8		; t = 80ms
	fcb $03,$fd,$b9	; f = 140.9Hz
	fcb 7		; t = 70ms
	fcb $03,$f0,$16	; f = 139.0Hz
	fcb 10		; t = 100ms
	fcb $03,$fd,$b9	; f = 140.9Hz
	fcb 7		; t = 70ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 7		; t = 70ms
	fcb $04,$2c,$b7	; f = 147.4Hz
	fcb 10		; t = 100ms
	fcb $04,$3c,$0e	; f = 149.5Hz
	fcb 7		; t = 70ms
	fcb $04,$be,$d7	; f = 167.6Hz
	fcb 7		; t = 70ms
	fcb $04,$ae,$c5	; f = 165.3Hz
	fcb 10		; t = 100ms
	fcb $04,$be,$d7	; f = 167.6Hz
	fcb 255		; t = to end of pattern
	fcb $05,$54,$dd	; f = 188.3Hz

song_freq_188
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 7		; t = 70ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 14		; t = 140ms
	fcb $05,$54,$dd	; f = 188.3Hz
	fcb 5		; t = 50ms
	fcb $05,$42,$9c	; f = 185.7Hz
	fcb 255		; t = to end of pattern
	fcb $05,$fa,$dc	; f = 211.1Hz

song_freq_189
	fcb 1		; t = 0ms (initial)
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 8		; t = 80ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $00,$fa,$b2	; f = 34.6Hz
	fcb 4		; t = 40ms
	fcb $00,$fe,$ee	; f = 35.2Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 8		; t = 80ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 4		; t = 40ms
	fcb $01,$f7,$7c	; f = 69.4Hz
	fcb 4		; t = 40ms
	fcb $02,$00,$04	; f = 70.6Hz
	fcb 255		; t = to end of pattern
	fcb $01,$95,$7d	; f = 55.9Hz

song_att_100
	fcb 13		; t = 120ms (initial)
	fcb 32		; t = 320ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_190
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 4		; t = 40ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 14		; t = 140ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 7		; t = 70ms
	fcb $06,$41,$2f	; f = 220.8Hz
	fcb 13		; t = 130ms
	fcb $06,$58,$23	; f = 224.0Hz
	fcb 255		; t = to end of pattern
	fcb $07,$f9,$26	; f = 281.5Hz

song_freq_191
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 7		; t = 70ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 7		; t = 70ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 7		; t = 70ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_192
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$fa,$dc	; f = 211.1Hz

song_freq_193
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 7		; t = 70ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 7		; t = 70ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 7		; t = 70ms
	fcb $07,$d9,$77	; f = 277.2Hz
	fcb 10		; t = 100ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_194
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$fa,$dc	; f = 211.1Hz

song_freq_195
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 7		; t = 70ms
	fcb $06,$ff,$0c	; f = 247.0Hz
	fcb 10		; t = 100ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 7		; t = 70ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 7		; t = 70ms
	fcb $06,$3e,$5c	; f = 220.5Hz
	fcb 10		; t = 100ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_196
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 255		; t = to end of pattern
	fcb $05,$e6,$73	; f = 208.3Hz

song_freq_197
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 7		; t = 70ms
	fcb $05,$e3,$f0	; f = 208.0Hz
	fcb 10		; t = 100ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 7		; t = 70ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $05,$40,$9d	; f = 185.5Hz
	fcb 10		; t = 100ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 7		; t = 70ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 7		; t = 70ms
	fcb $04,$ad,$2f	; f = 165.1Hz
	fcb 10		; t = 100ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_198
	fcb 5		; t = 40ms (initial)
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$fa,$dc	; f = 211.1Hz

song_freq_199
	fcb 7		; t = 60ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 255		; t = to end of pattern
	fcb $05,$e6,$73	; f = 208.3Hz

song_freq_200
	fcb 2		; t = 10ms (initial)
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$fa,$dc	; f = 211.1Hz

song_freq_201
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $05,$e6,$73	; f = 208.3Hz
	fcb 14		; t = 140ms
	fcb $05,$fa,$dc	; f = 211.1Hz
	fcb 255		; t = to end of pattern
	fcb $05,$e6,$73	; f = 208.3Hz

song_att_101
	fcb 93		; t = 920ms (initial)
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_att_102
	fcb 6		; t = 50ms (initial)
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 7		; t = 70ms
	fcb 54		; a = -4dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 7		; t = 70ms
	fcb 54		; a = -4dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 7		; t = 70ms
	fcb 54		; a = -4dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 7		; t = 70ms
	fcb 54		; a = -4dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_202
	fcb 21		; t = 200ms (initial)
	fcb 24		; t = 240ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 24		; t = 240ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 24		; t = 240ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_203
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 13		; t = 130ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 10		; t = 100ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_freq_204
	fcb 21		; t = 200ms (initial)
	fcb 24		; t = 240ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 24		; t = 240ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 24		; t = 240ms
	fcb $07,$f4,$8f	; f = 280.9Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_103
	fcb 29		; t = 280ms (initial)
	fcb 16		; t = 160ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_205
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 2		; t = 20ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 7		; t = 70ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 10		; t = 100ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_206
	fcb 21		; t = 200ms (initial)
	fcb 24		; t = 240ms
	fcb $07,$18,$2c	; f = 250.5Hz
	fcb 24		; t = 240ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 24		; t = 240ms
	fcb $06,$55,$3c	; f = 223.6Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_freq_207
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 2		; t = 20ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 7		; t = 70ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 7		; t = 70ms
	fcb $07,$dd,$ef	; f = 277.8Hz
	fcb 10		; t = 100ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 7		; t = 70ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 255		; t = to end of pattern
	fcb $09,$7d,$ad	; f = 335.1Hz

song_freq_208
	fcb 21		; t = 200ms (initial)
	fcb 24		; t = 240ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 24		; t = 240ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 24		; t = 240ms
	fcb $04,$bd,$36	; f = 167.3Hz
	fcb 255		; t = to end of pattern
	fcb $05,$52,$d0	; f = 188.0Hz

song_att_104
	fcb 29		; t = 280ms (initial)
	fcb 40		; t = 400ms
	fcb 68		; a = -2dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_209
	fcb 1		; t = 0ms (initial)
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 7		; t = 70ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 14		; t = 140ms
	fcb $09,$7d,$ad	; f = 335.1Hz
	fcb 5		; t = 50ms
	fcb $09,$5d,$8a	; f = 330.7Hz
	fcb 7		; t = 70ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 7		; t = 70ms
	fcb $07,$dd,$ef	; f = 277.8Hz
	fcb 10		; t = 100ms
	fcb $07,$f9,$26	; f = 281.5Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_105
	fcb 45		; t = 440ms (initial)
	fcb 48		; t = 480ms
	fcb 43		; a = -6dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_210
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_106
	fcb 6		; t = 50ms (initial)
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 7		; t = 70ms
	fcb 54		; a = -4dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 7		; t = 70ms
	fcb 54		; a = -4dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 7		; t = 70ms
	fcb 54		; a = -4dB
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 8		; t = 80ms
	fcb 85		; a = -0dB
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 8		; t = 80ms
	fcb 54		; a = -4dB
	fcb 255		; t = to end of pattern
	fcb 43		; a = -6dB

song_freq_211
	fcb 21		; t = 200ms (initial)
	fcb 24		; t = 240ms
	fcb $05,$f8,$47	; f = 210.8Hz
	fcb 24		; t = 240ms
	fcb $05,$52,$d0	; f = 188.0Hz
	fcb 255		; t = to end of pattern
	fcb $04,$bd,$36	; f = 167.3Hz

song_freq_212
	fcb 10		; t = 90ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 13		; t = 130ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $0b,$f5,$b9	; f = 422.3Hz

song_att_107
	fcb 6		; t = 50ms (initial)
	fcb 6		; t = 60ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 2		; t = 20ms
	fcb 17		; a = -14dB
	fcb 2		; t = 20ms
	fcb 13		; a = -16dB
	fcb 2		; t = 20ms
	fcb 11		; a = -18dB
	fcb 2		; t = 20ms
	fcb 9		; a = -20dB
	fcb 2		; t = 20ms
	fcb 7		; a = -22dB
	fcb 2		; t = 20ms
	fcb 5		; a = -24dB
	fcb 2		; t = 20ms
	fcb 4		; a = -26dB
	fcb 2		; t = 20ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

song_freq_213
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_freq_214
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 7		; t = 70ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 14		; t = 140ms
	fcb $0c,$b0,$47	; f = 448.0Hz
	fcb 5		; t = 50ms
	fcb $0c,$82,$5e	; f = 441.7Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_freq_215
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $06,$55,$3c	; f = 223.6Hz

song_freq_216
	fcb 13		; t = 120ms (initial)
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 14		; t = 140ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 7		; t = 70ms
	fcb $0a,$81,$3a	; f = 370.9Hz
	fcb 10		; t = 100ms
	fcb $0a,$a9,$ba	; f = 376.5Hz
	fcb 255		; t = to end of pattern
	fcb $0c,$b0,$47	; f = 448.0Hz

song_att_108
	fcb 6		; t = 50ms (initial)
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 8		; t = 80ms
	fcb 54		; a = -4dB
	fcb 8		; t = 80ms
	fcb 43		; a = -6dB
	fcb 6		; t = 60ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 2		; t = 20ms
	fcb 17		; a = -14dB
	fcb 2		; t = 20ms
	fcb 13		; a = -16dB
	fcb 2		; t = 20ms
	fcb 11		; a = -18dB
	fcb 2		; t = 20ms
	fcb 9		; a = -20dB
	fcb 2		; t = 20ms
	fcb 7		; a = -22dB
	fcb 2		; t = 20ms
	fcb 5		; a = -24dB
	fcb 2		; t = 20ms
	fcb 4		; a = -26dB
	fcb 2		; t = 20ms
	fcb 3		; a = -28dB
	fcb 37		; t = 370ms
	fcb 0		; a = OFF
	fcb 1		; t = 10ms
	fcb 27		; a = -10dB
	fcb 255		; t = to end of pattern
	fcb 85		; a = -0dB

song_freq_217
	fcb 93		; t = 920ms (initial)
	fcb 255		; t = to end of pattern
	fcb $05,$f8,$47	; f = 210.8Hz

song_freq_218
	fcb 4		; t = 30ms (initial)
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 7		; t = 70ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 14		; t = 140ms
	fcb $0b,$f5,$b9	; f = 422.3Hz
	fcb 5		; t = 50ms
	fcb $0b,$cc,$e6	; f = 416.7Hz
	fcb 255		; t = to end of pattern
	fcb $0a,$a9,$ba	; f = 376.5Hz

song_att_109
	fcb 6		; t = 50ms (initial)
	fcb 8		; t = 80ms
	fcb 68		; a = -2dB
	fcb 8		; t = 80ms
	fcb 54		; a = -4dB
	fcb 8		; t = 80ms
	fcb 43		; a = -6dB
	fcb 6		; t = 60ms
	fcb 34		; a = -8dB
	fcb 2		; t = 20ms
	fcb 27		; a = -10dB
	fcb 2		; t = 20ms
	fcb 21		; a = -12dB
	fcb 2		; t = 20ms
	fcb 17		; a = -14dB
	fcb 2		; t = 20ms
	fcb 13		; a = -16dB
	fcb 2		; t = 20ms
	fcb 11		; a = -18dB
	fcb 2		; t = 20ms
	fcb 9		; a = -20dB
	fcb 2		; t = 20ms
	fcb 7		; a = -22dB
	fcb 2		; t = 20ms
	fcb 5		; a = -24dB
	fcb 2		; t = 20ms
	fcb 4		; a = -26dB
	fcb 2		; t = 20ms
	fcb 3		; a = -28dB
	fcb 255		; t = to end of pattern
	fcb 0		; a = OFF

