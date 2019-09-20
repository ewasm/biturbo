
  ;; ethash_keccakf1600
  (func $ethash_keccakf1600 (param $p0 i32)
    (local $l1 i32) (local $l2 i32) (local $l3 i64) (local $l4 i64) (local $l5 i64) (local $l6 i64) (local $l7 i64) (local $l8 i64) (local $l9 i64) (local $l10 i64) (local $l11 i64) (local $l12 i64) (local $l13 i64) (local $l14 i64) (local $l15 i64) (local $l16 i64) (local $l17 i64) (local $l18 i64) (local $l19 i64) (local $l20 i64) (local $l21 i64) (local $l22 i64) (local $l23 i64) (local $l24 i64) (local $l25 i64) (local $l26 i64) (local $l27 i64) (local $l28 i64) (local $l29 i64) (local $l30 i64) (local $l31 i64) (local $l32 i64) (local $l33 i64) (local $l34 i64) (local $l35 i64) (local $l36 i64) (local $l37 i64) (local $l38 i64) (local $l39 i64) (local $l40 i64) (local $l41 i64) (local $l42 i64) (local $l43 i64) (local $l44 i64) (local $l45 i64) (local $l46 i64) (local $l47 i64) (local $l48 i64) (local $l49 i64) (local $l50 i64) (local $l51 i64)
    (local.set $l20
      (i64.load
        (local.get $p0)))
    (local.set $l21
      (i64.load offset=8
        (local.get $p0)))
    (local.set $l37
      (i64.load offset=16
        (local.get $p0)))
    (local.set $l22
      (i64.load offset=24
        (local.get $p0)))
    (local.set $l23
      (i64.load offset=32
        (local.get $p0)))
    (local.set $l24
      (i64.load offset=40
        (local.get $p0)))
    (local.set $l11
      (i64.load offset=48
        (local.get $p0)))
    (local.set $l25
      (i64.load offset=56
        (local.get $p0)))
    (local.set $l26
      (i64.load
        (local.tee $l2
          (i32.sub
            (local.get $p0)
            (i32.const -64)))))
    (local.set $l14
      (i64.load offset=72
        (local.get $p0)))
    (local.set $l15
      (i64.load offset=80
        (local.get $p0)))
    (local.set $l27
      (i64.load offset=88
        (local.get $p0)))
    (local.set $l8
      (i64.load offset=96
        (local.get $p0)))
    (local.set $l16
      (i64.load offset=104
        (local.get $p0)))
    (local.set $l17
      (i64.load offset=112
        (local.get $p0)))
    (local.set $l32
      (i64.load offset=120
        (local.get $p0)))
    (local.set $l19
      (i64.load offset=128
        (local.get $p0)))
    (local.set $l12
      (i64.load offset=136
        (local.get $p0)))
    (local.set $l10
      (i64.load offset=144
        (local.get $p0)))
    (local.set $l4
      (i64.load offset=152
        (local.get $p0)))
    (local.set $l9
      (i64.load offset=160
        (local.get $p0)))
    (local.set $l33
      (i64.load offset=168
        (local.get $p0)))
    (local.set $l6
      (i64.load offset=176
        (local.get $p0)))
    (local.set $l5
      (i64.load offset=184
        (local.get $p0)))
    (local.set $l3
      (i64.load offset=192
        (local.get $p0)))
    (loop $L0
      (local.set $l36
        (i64.xor
          (local.tee $l35
            (i64.xor
              (local.get $l23)
              (i64.xor
                (local.get $l14)
                (i64.xor
                  (local.get $l17)
                  (i64.xor
                    (local.get $l3)
                    (local.get $l4))))))
          (i64.or
            (i64.shl
              (local.tee $l34
                (i64.xor
                  (local.get $l21)
                  (i64.xor
                    (local.get $l11)
                    (i64.xor
                      (local.get $l27)
                      (i64.xor
                        (local.get $l19)
                        (local.get $l33))))))
              (i64.const 1))
            (i64.shr_u
              (local.get $l34)
              (i64.const 63)))))
      (local.set $l40
        (i64.xor
          (i64.load
            (i32.add
              (i32.shl
                (local.get $l1)
                (i32.const 3))
              (i32.const 1024)))
          (i64.xor
            (local.tee $l39
              (i64.xor
                (local.get $l20)
                (local.get $l36)))
            (i64.and
              (i64.xor
                (local.tee $l28
                  (i64.or
                    (i64.shl
                      (local.tee $l11
                        (i64.xor
                          (local.get $l11)
                          (local.tee $l38
                            (i64.xor
                              (local.tee $l13
                                (i64.xor
                                  (local.get $l20)
                                  (i64.xor
                                    (local.get $l24)
                                    (i64.xor
                                      (local.get $l15)
                                      (i64.xor
                                        (local.get $l9)
                                        (local.get $l32))))))
                              (i64.or
                                (i64.shl
                                  (local.tee $l7
                                    (i64.xor
                                      (local.get $l37)
                                      (i64.xor
                                        (local.get $l25)
                                        (i64.xor
                                          (local.get $l8)
                                          (i64.xor
                                            (local.get $l6)
                                            (local.get $l12))))))
                                  (i64.const 1))
                                (i64.shr_u
                                  (local.get $l7)
                                  (i64.const 63)))))))
                      (i64.const 44))
                    (i64.shr_u
                      (local.get $l11)
                      (i64.const 20))))
                (i64.const -1))
              (local.tee $l8
                (i64.or
                  (i64.shl
                    (local.tee $l8
                      (i64.xor
                        (local.get $l8)
                        (local.tee $l18
                          (i64.xor
                            (i64.or
                              (i64.shl
                                (local.tee $l11
                                  (i64.xor
                                    (local.get $l22)
                                    (i64.xor
                                      (local.get $l26)
                                      (i64.xor
                                        (local.get $l16)
                                        (i64.xor
                                          (local.get $l5)
                                          (local.get $l10))))))
                                (i64.const 1))
                              (i64.shr_u
                                (local.get $l11)
                                (i64.const 63)))
                            (local.get $l34)))))
                    (i64.const 43))
                  (i64.shr_u
                    (local.get $l8)
                    (i64.const 21))))))))
      (local.set $l42
        (i64.xor
          (i64.and
            (local.tee $l41
              (i64.or
                (i64.shl
                  (local.tee $l10
                    (i64.xor
                      (local.get $l10)
                      (local.tee $l7
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l35)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l35)
                              (i64.const 63)))
                          (local.get $l7)))))
                  (i64.const 21))
                (i64.shr_u
                  (local.get $l10)
                  (i64.const 43))))
            (i64.xor
              (local.get $l8)
              (i64.const -1)))
          (local.get $l28)))
      (local.set $l44
        (i64.xor
          (i64.and
            (local.tee $l43
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l3)
                      (local.tee $l13
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l13)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l13)
                              (i64.const 63)))
                          (local.get $l11)))))
                  (i64.const 14))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 50))))
            (i64.xor
              (local.get $l41)
              (i64.const -1)))
          (local.get $l8)))
      (local.set $l46
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l14
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l13)
                        (local.get $l14)))
                    (i64.const 20))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 44))))
              (i64.const -1))
            (local.tee $l10
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l15)
                      (local.get $l36)))
                  (i64.const 3))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 61)))))
          (local.tee $l45
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l7)
                    (local.get $l22)))
                (i64.const 28))
              (i64.shr_u
                (local.get $l3)
                (i64.const 36))))))
      (local.set $l29
        (i64.xor
          (i64.and
            (local.tee $l47
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l19)
                      (local.get $l38)))
                  (i64.const 45))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 19))))
            (i64.xor
              (local.get $l10)
              (i64.const -1)))
          (local.get $l14)))
      (local.set $l48
        (i64.xor
          (i64.and
            (local.tee $l30
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l6)
                      (local.get $l18)))
                  (i64.const 61))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 3))))
            (i64.xor
              (local.get $l47)
              (i64.const -1)))
          (local.get $l10)))
      (local.set $l49
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l15
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l18)
                        (local.get $l25)))
                    (i64.const 6))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 58))))
              (i64.const -1))
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l7)
                      (local.get $l16)))
                  (i64.const 25))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 39)))))
          (local.tee $l31
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l21)
                    (local.get $l38)))
                (i64.const 1))
              (i64.shr_u
                (local.get $l3)
                (i64.const 63))))))
      (local.set $l50
        (i64.xor
          (i64.and
            (local.tee $l20
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l4)
                      (local.get $l13)))
                  (i64.const 8))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 56))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l15)))
      (local.set $l22
        (i64.xor
          (i64.and
            (local.tee $l21
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l9)
                      (local.get $l36)))
                  (i64.const 18))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 46))))
            (i64.xor
              (local.get $l20)
              (i64.const -1)))
          (local.get $l6)))
      (local.set $l51
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l10
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l24)
                        (local.get $l36)))
                    (i64.const 36))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 28))))
              (i64.const -1))
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l27)
                      (local.get $l38)))
                  (i64.const 10))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 54)))))
          (local.tee $l23
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l13)
                    (local.get $l23)))
                (i64.const 27))
              (i64.shr_u
                (local.get $l3)
                (i64.const 37))))))
      (local.set $l11
        (i64.xor
          (i64.and
            (local.tee $l24
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l12)
                      (local.get $l18)))
                  (i64.const 15))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 49))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l10)))
      (local.set $l34
        (i64.xor
          (i64.and
            (local.tee $l8
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l5)
                      (local.get $l7)))
                  (i64.const 56))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 8))))
            (i64.xor
              (local.get $l24)
              (i64.const -1)))
          (local.get $l6)))
      (local.set $l7
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l4
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l7)
                        (local.get $l26)))
                    (i64.const 55))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 9))))
              (i64.const -1))
            (local.tee $l9
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l13)
                      (local.get $l17)))
                  (i64.const 39))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 25)))))
          (local.tee $l16
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l18)
                    (local.get $l37)))
                (i64.const 62))
              (i64.shr_u
                (local.get $l3)
                (i64.const 2))))))
      (local.set $l35
        (i64.xor
          (i64.and
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l32)
                      (local.get $l36)))
                  (i64.const 41))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 23))))
            (i64.xor
              (local.get $l9)
              (i64.const -1)))
          (local.get $l4)))
      (local.set $l25
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l33)
                      (local.get $l38)))
                  (i64.const 2))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 62))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l9)))
      (local.set $l18
        (i64.xor
          (local.tee $l26
            (i64.xor
              (local.tee $l32
                (i64.xor
                  (i64.and
                    (i64.xor
                      (local.get $l23)
                      (i64.const -1))
                    (local.get $l10))
                  (local.get $l8)))
              (i64.xor
                (local.tee $l19
                  (i64.xor
                    (i64.and
                      (i64.xor
                        (local.get $l45)
                        (i64.const -1))
                      (local.get $l14))
                    (local.get $l30)))
                (i64.xor
                  (local.tee $l10
                    (i64.xor
                      (i64.and
                        (i64.xor
                          (local.get $l39)
                          (i64.const -1))
                        (local.get $l28))
                      (local.get $l43)))
                  (i64.xor
                    (local.tee $l13
                      (i64.xor
                        (i64.and
                          (i64.xor
                            (local.get $l31)
                            (i64.const -1))
                          (local.get $l15))
                        (local.get $l21)))
                    (local.tee $l12
                      (i64.xor
                        (i64.and
                          (i64.xor
                            (local.get $l16)
                            (i64.const -1))
                          (local.get $l4))
                        (local.get $l5))))))))
          (i64.or
            (i64.shl
              (local.tee $l17
                (i64.xor
                  (local.get $l35)
                  (i64.xor
                    (local.get $l50)
                    (i64.xor
                      (i64.xor
                        (local.get $l11)
                        (local.get $l42))
                      (local.get $l29)))))
              (i64.const 1))
            (i64.shr_u
              (local.get $l17)
              (i64.const 63)))))
      (local.set $l20
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l27
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.tee $l28
                          (i64.xor
                            (local.tee $l15
                              (i64.xor
                                (i64.xor
                                  (local.get $l7)
                                  (i64.xor
                                    (i64.xor
                                      (local.get $l49)
                                      (local.get $l51))
                                    (local.get $l46)))
                                (local.get $l40)))
                            (i64.or
                              (i64.shl
                                (local.tee $l14
                                  (i64.xor
                                    (local.get $l22)
                                    (i64.xor
                                      (i64.xor
                                        (local.get $l25)
                                        (i64.xor
                                          (local.get $l34)
                                          (local.get $l48)))
                                      (local.get $l44))))
                                (i64.const 1))
                              (i64.shr_u
                                (local.get $l14)
                                (i64.const 63)))))
                        (local.get $l29)))
                    (i64.const 44))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 20))))
              (i64.const -1))
            (local.tee $l16
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l22)
                      (local.tee $l29
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.tee $l8
                                (i64.xor
                                  (local.tee $l4
                                    (i64.xor
                                      (i64.and
                                        (i64.xor
                                          (local.get $l8)
                                          (i64.const -1))
                                        (local.get $l23))
                                      (local.get $l24)))
                                  (i64.xor
                                    (i64.xor
                                      (local.tee $l9
                                        (i64.xor
                                          (i64.and
                                            (i64.xor
                                              (local.get $l21)
                                              (i64.const -1))
                                            (local.get $l31))
                                          (local.get $l20)))
                                      (i64.xor
                                        (local.tee $l33
                                          (i64.xor
                                            (i64.and
                                              (i64.xor
                                                (local.get $l5)
                                                (i64.const -1))
                                              (local.get $l16))
                                            (local.get $l6)))
                                        (local.tee $l6
                                          (i64.xor
                                            (i64.and
                                              (i64.xor
                                                (local.get $l30)
                                                (i64.const -1))
                                              (local.get $l45))
                                            (local.get $l47)))))
                                    (local.tee $l5
                                      (i64.xor
                                        (i64.and
                                          (i64.xor
                                            (local.get $l43)
                                            (i64.const -1))
                                          (local.get $l39))
                                        (local.get $l41))))))
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l8)
                              (i64.const 63)))
                          (local.get $l17)))))
                  (i64.const 43))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 21)))))
          (i64.xor
            (local.tee $l17
              (i64.xor
                (local.get $l18)
                (local.get $l40)))
            (i64.load
              (i32.add
                (i32.shl
                  (i32.or
                    (local.get $l1)
                    (i32.const 1))
                  (i32.const 3))
                (i32.const 1024))))))
      (local.set $l21
        (i64.xor
          (i64.and
            (local.tee $l4
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l4)
                      (local.tee $l30
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l26)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l26)
                              (i64.const 63)))
                          (local.get $l14)))))
                  (i64.const 21))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 43))))
            (i64.xor
              (local.get $l16)
              (i64.const -1)))
          (local.get $l27)))
      (local.set $l37
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l12)
                      (local.tee $l31
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l15)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l15)
                              (i64.const 63)))
                          (local.get $l8)))))
                  (i64.const 14))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 50))))
            (i64.xor
              (local.get $l4)
              (i64.const -1)))
          (local.get $l16)))
      (local.set $l22
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l17))
          (local.get $l4)))
      (local.set $l23
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l17)
              (i64.const -1))
            (local.get $l27))
          (local.get $l3)))
      (local.set $l24
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l19
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l19)
                        (local.get $l31)))
                    (i64.const 20))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 44))))
              (i64.const -1))
            (local.tee $l12
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l18)
                      (local.get $l49)))
                  (i64.const 3))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 61)))))
          (local.tee $l4
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l5)
                    (local.get $l30)))
                (i64.const 28))
              (i64.shr_u
                (local.get $l3)
                (i64.const 36))))))
      (local.set $l11
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l11)
                      (local.get $l28)))
                  (i64.const 45))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 19))))
            (i64.xor
              (local.get $l12)
              (i64.const -1)))
          (local.get $l19)))
      (local.set $l25
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l25)
                      (local.get $l29)))
                  (i64.const 61))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 3))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l12)))
      (local.set $l26
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l4))
          (local.get $l5)))
      (local.set $l14
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l4)
              (i64.const -1))
            (local.get $l19))
          (local.get $l3)))
      (local.set $l15
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l12
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l29)
                        (local.get $l48)))
                    (i64.const 6))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 58))))
              (i64.const -1))
            (local.tee $l4
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l9)
                      (local.get $l30)))
                  (i64.const 25))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 39)))))
          (local.tee $l9
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l28)
                    (local.get $l42)))
                (i64.const 1))
              (i64.shr_u
                (local.get $l3)
                (i64.const 63))))))
      (local.set $l27
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l31)
                      (local.get $l32)))
                  (i64.const 8))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 56))))
            (i64.xor
              (local.get $l4)
              (i64.const -1)))
          (local.get $l12)))
      (local.set $l8
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l7)
                      (local.get $l18)))
                  (i64.const 18))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 46))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l4)))
      (local.set $l16
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l9))
          (local.get $l5)))
      (local.set $l17
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l9)
              (i64.const -1))
            (local.get $l12))
          (local.get $l3)))
      (local.set $l32
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l7
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l18)
                        (local.get $l46)))
                    (i64.const 36))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 28))))
              (i64.const -1))
            (local.tee $l4
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l28)
                      (local.get $l50)))
                  (i64.const 10))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 54)))))
          (local.tee $l9
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l10)
                    (local.get $l31)))
                (i64.const 27))
              (i64.shr_u
                (local.get $l3)
                (i64.const 37))))))
      (local.set $l19
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l29)
                      (local.get $l34)))
                  (i64.const 15))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 49))))
            (i64.xor
              (local.get $l4)
              (i64.const -1)))
          (local.get $l7)))
      (local.set $l12
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l30)
                      (local.get $l33)))
                  (i64.const 56))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 8))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l4)))
      (local.set $l10
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l9))
          (local.get $l5)))
      (local.set $l4
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l9)
              (i64.const -1))
            (local.get $l7))
          (local.get $l3)))
      (local.set $l9
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l7
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l6)
                        (local.get $l30)))
                    (i64.const 55))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 9))))
              (i64.const -1))
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l13)
                      (local.get $l31)))
                  (i64.const 39))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 25)))))
          (local.tee $l13
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l29)
                    (local.get $l44)))
                (i64.const 62))
              (i64.shr_u
                (local.get $l3)
                (i64.const 2))))))
      (local.set $l33
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l18)
                      (local.get $l51)))
                  (i64.const 41))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 23))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l7)))
      (local.set $l6
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l28)
                      (local.get $l35)))
                  (i64.const 2))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 62))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l6)))
      (local.set $l5
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l13))
          (local.get $l5)))
      (local.set $l3
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l13)
              (i64.const -1))
            (local.get $l7))
          (local.get $l3)))
      (br_if $L0
        (i32.lt_u
          (local.tee $l1
            (i32.add
              (local.get $l1)
              (i32.const 2)))
          (i32.const 24))))
    (i64.store
      (local.get $p0)
      (local.get $l20))
    (i64.store offset=8
      (local.get $p0)
      (local.get $l21))
    (i64.store offset=16
      (local.get $p0)
      (local.get $l37))
    (i64.store offset=24
      (local.get $p0)
      (local.get $l22))
    (i64.store offset=32
      (local.get $p0)
      (local.get $l23))
    (i64.store offset=40
      (local.get $p0)
      (local.get $l24))
    (i64.store offset=48
      (local.get $p0)
      (local.get $l11))
    (i64.store offset=56
      (local.get $p0)
      (local.get $l25))
    (i64.store
      (local.get $l2)
      (local.get $l26))
    (i64.store offset=72
      (local.get $p0)
      (local.get $l14))
    (i64.store offset=80
      (local.get $p0)
      (local.get $l15))
    (i64.store offset=88
      (local.get $p0)
      (local.get $l27))
    (i64.store offset=96
      (local.get $p0)
      (local.get $l8))
    (i64.store offset=104
      (local.get $p0)
      (local.get $l16))
    (i64.store offset=112
      (local.get $p0)
      (local.get $l17))
    (i64.store offset=120
      (local.get $p0)
      (local.get $l32))
    (i64.store offset=128
      (local.get $p0)
      (local.get $l19))
    (i64.store offset=136
      (local.get $p0)
      (local.get $l12))
    (i64.store offset=144
      (local.get $p0)
      (local.get $l10))
    (i64.store offset=152
      (local.get $p0)
      (local.get $l4))
    (i64.store offset=160
      (local.get $p0)
      (local.get $l9))
    (i64.store offset=168
      (local.get $p0)
      (local.get $l33))
    (i64.store offset=176
      (local.get $p0)
      (local.get $l6))
    (i64.store offset=184
      (local.get $p0)
      (local.get $l5))
    (i64.store offset=192
      (local.get $p0)
      (local.get $l3)))

  ;; https://github.com/chfast/ethash/blob/master/lib/keccak/keccak.c#L97
  ;; union ethash_hash256 ethash_keccak256(const uint8_t* data, size_t size)
  ;; {
  ;;     union ethash_hash256 hash;
  ;;     // keccak() here is always inlined
  ;;     keccak(hash.word64s, 256, data, size);
  ;;     return hash;
  ;; }
  ;;
  ;; static INLINE ALWAYS_INLINE void keccak(
  ;;   uint64_t* out, size_t bits, const uint8_t* data, size_t size)
  ;; {


;;(func $watimports.$ethash_keccak256 (param $p0 i32) (param $p1 i32) (param $p2 i32)
(func $keccak/ethash_keccak256 (param $p0 i32) (param $p1 i32) (param $p2 i32)
    (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i32) (local $l9 i32) (local $l10 i32) (local $l11 i32) (local $l12 i64) (local $l13 i64) (local $l14 i64) (local $l15 i64) (local $l16 i64) (local $l17 i64) (local $l18 i64) (local $l19 i64) (local $l20 i64) (local $l21 i64) (local $l22 i64) (local $l23 i64) (local $l24 i64) (local $l25 i64)
    ;; (call $main/debug (i32.const 1)) ;; count number of times hash function is called
    (local.set $l8
      (global.get $g0_ethash_keccak))
    (global.set $g0_ethash_keccak
      (i32.add
        (global.get $g0_ethash_keccak)
        (i32.const 208)))
    (i64.store
      (local.tee $l7
        (i32.add
          (local.get $l8)
          (i32.const 200)))
      (i64.const 0))
    (drop
      (call $f2_ethash_keccak
        (local.tee $l3
          (local.get $l8))
        (i32.const 0)
        (i32.const 200)))

    ;; while (size >= block_size)
    (if $I0
      (i32.ge_u
        (local.get $p2)
        (i32.const 136))
      (then
        (local.set $l4
          (i32.sub
            (local.get $l3)
            (i32.const -64)))

        (loop $L1
          (i64.store
            (local.get $l3)
            (i64.xor
              (local.get $l12)
              (i64.load align=1
                (local.get $p1))))
          (i64.store offset=8
            (local.get $l3)
            (i64.xor
              (local.get $l13)
              (i64.load offset=8 align=1
                (local.get $p1))))
          (i64.store offset=16
            (local.get $l3)
            (i64.xor
              (local.get $l18)
              (i64.load offset=16 align=1
                (local.get $p1))))
          (i64.store offset=24
            (local.get $l3)
            (i64.xor
              (local.get $l19)
              (i64.load offset=24 align=1
                (local.get $p1))))
          (i64.store offset=32
            (local.get $l3)
            (i64.xor
              (local.get $l20)
              (i64.load offset=32 align=1
                (local.get $p1))))
          (i64.store offset=40
            (local.get $l3)
            (i64.xor
              (local.get $l21)
              (i64.load offset=40 align=1
                (local.get $p1))))
          (i64.store offset=48
            (local.get $l3)
            (i64.xor
              (local.get $l22)
              (i64.load offset=48 align=1
                (local.get $p1))))
          (i64.store offset=56
            (local.get $l3)
            (i64.xor
              (local.get $l23)
              (i64.load offset=56 align=1
                (local.get $p1))))
          (i64.store
            (local.get $l4)
            (i64.xor
              (local.get $l24)
              (i64.load align=1
                (i32.sub
                  (local.get $p1)
                  (i32.const -64)))))
          (i64.store offset=72
            (local.get $l3)
            (i64.xor
              (local.get $l25)
              (i64.load offset=72 align=1
                (local.get $p1))))
          (i64.store offset=80
            (local.get $l3)
            (i64.xor
              (local.get $l14)
              (i64.load offset=80 align=1
                (local.get $p1))))
          (i64.store offset=88
            (local.get $l3)
            (i64.xor
              (local.get $l15)
              (i64.load offset=88 align=1
                (local.get $p1))))
          (i64.store offset=96
            (local.get $l3)
            (i64.xor
              (local.get $l16)
              (i64.load offset=96 align=1
                (local.get $p1))))
          (i64.store offset=104
            (local.get $l3)
            (i64.xor
              (local.get $l17)
              (i64.load offset=104 align=1
                (local.get $p1))))
          (i64.store offset=112
            (local.get $l3)
            (i64.xor
              (i64.load offset=112
                (local.get $l3))
              (i64.load offset=112 align=1
                (local.get $p1))))
          (i64.store offset=120
            (local.get $l3)
            (i64.xor
              (i64.load offset=120
                (local.get $l3))
              (i64.load offset=120 align=1
                (local.get $p1))))
          (i64.store offset=128
            (local.get $l3)
            (i64.xor
              (i64.load offset=128
                (local.get $l3))
              (i64.load offset=128 align=1
                (local.get $p1))))
          (local.set $p1
            (i32.add
              (local.get $p1)
              (i32.const 136)))


          ;; 136 == const size_t block_size = (1600 - bits * 2) / 8;
          ;; ethash_keccakf1600
          (call $ethash_keccakf1600
            (local.get $l3))
          (if $I2
            (i32.ge_u
              (local.tee $p2
                (i32.add
                  (local.get $p2)
                  (i32.const -136)))
              (i32.const 136))
            (then
              (local.set $l12
                (i64.load
                  (local.get $l3)))
              (local.set $l13
                (i64.load offset=8
                  (local.get $l3)))
              (local.set $l14
                (i64.load offset=80
                  (local.get $l3)))
              (local.set $l15
                (i64.load offset=88
                  (local.get $l3)))
              (local.set $l16
                (i64.load offset=96
                  (local.get $l3)))
              (local.set $l17
                (i64.load offset=104
                  (local.get $l3)))
              (local.set $l18
                (i64.load offset=16
                  (local.get $l3)))
              (local.set $l19
                (i64.load offset=24
                  (local.get $l3)))
              (local.set $l20
                (i64.load offset=32
                  (local.get $l3)))
              (local.set $l21
                (i64.load offset=40
                  (local.get $l3)))
              (local.set $l22
                (i64.load offset=48
                  (local.get $l3)))
              (local.set $l23
                (i64.load offset=56
                  (local.get $l3)))
              (local.set $l24
                (i64.load
                  (local.get $l4)))
              (local.set $l25
                (i64.load offset=72
                  (local.get $l3)))
              (br $L1))))))

    ;; while (size >= word_size) ??

    (local.set $l5
      (if $I3 (result i32)
        (i32.gt_u
          (local.get $p2)
          (i32.const 7))
        (then
          (i32.add
            (i32.shl
              (i32.add
                (block $B4 (result i32)
                  (local.set $l11
                    (i32.shr_u
                      (local.tee $l5
                        (i32.add
                          (local.get $p2)
                          (i32.const -8)))
                      (i32.const 3)))
                  (local.set $l9
                    (i32.and
                      (local.get $l5)
                      (i32.const -8)))
                  (local.set $l4
                    (local.get $p1))
                  (local.set $l6
                    (local.get $p2))
                  (local.set $p2
                    (local.get $l3))
                  (loop $L5
                    (i64.store
                      (local.get $p2)
                      (i64.xor
                        (i64.load
                          (local.get $p2))
                        (i64.load align=1
                          (local.get $l4))))
                    (local.set $p2
                      (i32.add
                        (local.get $p2)
                        (i32.const 8)))
                    (local.set $l4
                      (i32.add
                        (local.get $l4)
                        (i32.const 8)))
                    (br_if $L5
                      (i32.gt_u
                        (local.tee $l6
                          (i32.add
                            (local.get $l6)
                            (i32.const -8)))
                        (i32.const 7))))
                  (local.set $p1
                    (i32.add
                      (i32.add
                        (local.get $l9)
                        (i32.const 8))
                      (local.get $p1)))
                  (local.set $l6
                    (i32.sub
                      (local.get $l5)
                      (local.get $l9)))
                  (local.get $l11))
                (i32.const 1))
              (i32.const 3))
            (local.get $l3)))
        (else
          (local.set $l6
            (local.get $p2))
          (local.get $l3))))


    ;; while (size >= block_size) ??
    ;; loop merged with while (size >= word_size) ??

    (if $I6
      (i32.eqz
        (local.get $l6))
      (then
        (i32.store8
          (local.get $l7)
          (i32.const 1))
        (i64.store
          (local.get $l5)
          (i64.xor
            (i64.load
              (local.get $l7))
            (i64.load
              (local.get $l5))))
        (i64.store offset=128
          (local.get $l3)
          (i64.xor
            (i64.load offset=128
              (local.get $l3))
            (i64.const -9223372036854775808)))
 
        ;; ethash_keccakf1600 
        (call $ethash_keccakf1600
          (local.get $l3))

        ;; to_le64(state[i])
        (i64.store
          (local.get $p0)
          (i64.load
            (local.get $l3)))
        (i64.store offset=8
          (local.get $p0)
          (i64.load offset=8
            (local.get $l3)))
        (i64.store offset=16
          (local.get $p0)
          (i64.load offset=16
            (local.get $l3)))
        (i64.store offset=24
          (local.get $p0)
          (i64.load offset=24
            (local.get $l3)))
        (global.set $g0_ethash_keccak
          (local.get $l8))
        (return)))


    (local.set $p2
      (local.get $l7))
    (local.set $l4
      (local.get $l6))

    ;;  while (size > 0)
    (loop $L7
      (i32.store8
        (local.get $p2)
        (i32.load8_s
          (local.get $p1)))
      (local.set $p2
        (i32.add
          (local.get $p2)
          (i32.const 1)))
      (local.set $p1
        (i32.add
          (local.get $p1)
          (i32.const 1)))
      (br_if $L7
        (local.tee $l4
          (i32.add
            (local.get $l4)
            (i32.const -1)))))

    ;; *last_word_iter = 0x01;
    (i32.store8
      (i32.add
        (local.get $l6)
        (local.get $l7))
      (i32.const 1))

    ;; *state_iter ^= to_le64(last_word);
    (i64.store
      (local.get $l5)
      (i64.xor
        (i64.load
          (local.get $l7))
        (i64.load
          (local.get $l5))))

    ;; state[(block_size / word_size) - 1] ^= 0x8000000000000000;
    (i64.store offset=128
      (local.get $l3)
      (i64.xor
        (i64.load offset=128
          (local.get $l3))
        (i64.const -9223372036854775808)))

    ;; ethash_keccakf1600
    (call $ethash_keccakf1600
      (local.get $l3))

    ;; for (i = 0; i < (hash_size / word_size); ++i)
    ;;    out[i] = to_le64(state[i]);
    (i64.store
      (local.get $p0)
      (i64.load
        (local.get $l3)))
    (i64.store offset=8
      (local.get $p0)
      (i64.load offset=8
        (local.get $l3)))
    (i64.store offset=16
      (local.get $p0)
      (i64.load offset=16
        (local.get $l3)))
    (i64.store offset=24
      (local.get $p0)
      (i64.load offset=24
        (local.get $l3)))
    (global.set $g0_ethash_keccak
      (local.get $l8)))


  ;; not sure what $f2 does
  (func $f2_ethash_keccak (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32)
    (local.set $l4
      (i32.add
        (local.get $p0)
        (local.get $p2)))
    (local.set $l3
      (i32.and
        (local.get $p1)
        (i32.const 255)))
    (if $I0
      (i32.ge_s
        (local.get $p2)
        (i32.const 67))
      (then
        (loop $L1
          (if $I2
            (i32.and
              (local.get $p0)
              (i32.const 3))
            (then
              (i32.store8
                (local.get $p0)
                (local.get $l3))
              (local.set $p0
                (i32.add
                  (local.get $p0)
                  (i32.const 1)))
              (br $L1))))
        (local.set $p1
          (i32.or
            (i32.or
              (i32.or
                (i32.shl
                  (local.get $l3)
                  (i32.const 8))
                (local.get $l3))
              (i32.shl
                (local.get $l3)
                (i32.const 16)))
            (i32.shl
              (local.get $l3)
              (i32.const 24))))
        (local.set $l6
          (i32.add
            (local.tee $l5
              (i32.and
                (local.get $l4)
                (i32.const -4)))
            (i32.const -64)))
        (loop $L3
          (if $I4
            (i32.le_s
              (local.get $p0)
              (local.get $l6))
            (then
              (i32.store
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=4
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=8
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=12
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=16
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=20
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=24
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=28
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=32
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=36
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=40
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=44
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=48
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=52
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=56
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=60
                (local.get $p0)
                (local.get $p1))
              (local.set $p0
                (i32.sub
                  (local.get $p0)
                  (i32.const -64)))
              (br $L3))))
        (loop $L5
          (if $I6
            (i32.lt_s
              (local.get $p0)
              (local.get $l5))
            (then
              (i32.store
                (local.get $p0)
                (local.get $p1))
              (local.set $p0
                (i32.add
                  (local.get $p0)
                  (i32.const 4)))
              (br $L5))))))
    (loop $L7
      (if $I8
        (i32.lt_s
          (local.get $p0)
          (local.get $l4))
        (then
          (i32.store8
            (local.get $p0)
            (local.get $l3))
          (local.set $p0
            (i32.add
              (local.get $p0)
              (i32.const 1)))
          (br $L7))))
    (i32.sub
      (local.get $l4)
      (local.get $p2)))

  ;; (func $main (export "main")
  ;;   (local $l0 i64)
  ;;   (local.set $l0
  ;;     (i64.const 200))
  ;;   (block $B0
  ;;     (loop $L1
  ;;       (i64.store
  ;;         (i32.const 0)
  ;;         (local.get $l0))
  ;;       (call $_ethash_keccak256
  ;;         (i32.const 16384)
  ;;         (i32.const 0)
  ;;         (i32.const 266))
  ;;       (br_if $B0
  ;;         (i64.eqz
  ;;           (local.tee $l0
  ;;             (i64.sub
  ;;               (local.get $l0)
  ;;               (i64.const 1)))))
  ;;       (br $L1))))


  ;; (func $main (export "main")
  ;;   (call $ethash_keccak256
  ;;     (i32.const 16384) ;; output offset 1024 * 16
  ;;     (i32.const 0)    ;; mem offset in
  ;;     (i32.const 266)  ;; input length
  ;;   )
  ;;   (return 0)
  ;; )

  (global $g0_ethash_keccak (mut i32) (i32.const 2960))
  (data $d0_ethash_keccak (i32.const 1024) "\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8a\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8b\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8a\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0a\00\00\80\00\00\00\00\8b\80\00\80\00\00\00\00\8b\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0a\80\00\00\00\00\00\00\0a\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80")