/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT-0-zpoddult.aml, Wed Dec  5 20:30:39 2018
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000174 (372)
 *     Revision         0x01
 *     Checksum         0xD9
 *     OEM ID           "Intel"
 *     OEM Table ID     "zpoddult"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120711 (538052369)
 */
DefinitionBlock ("", "SSDT", 1, "Intel", "zpoddult", 0x00001000)
{
    External (_SB_.PCI0.SAT0, DeviceObj)
    External (FDTP, IntObj)
    External (GR00, FieldUnitObj)
    External (PFLV, FieldUnitObj)
    External (RGPL, MethodObj)    // 2 Arguments
    External (RTD3, FieldUnitObj)
    External (SGPL, MethodObj)    // 3 Arguments
    External (SGPP, MethodObj)    // 2 Arguments

    If (LEqual (RTD3, Zero))
    {
        Scope (\_SB.PCI0.SAT0)
        {
            Device (PRT1)
            {
                Name (_ADR, 0x0001FFFF)  // _ADR: Address
                Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                {
                    If (LEqual (Arg0, ToUUID ("bdfaef30-aebb-11de-8a39-0800200c9a66")))
                    {
                        Switch (ToInteger (Arg2))
                        {
                            Case (Zero)
                            {
                                Switch (ToInteger (Arg1))
                                {
                                    Case (One)
                                    {
                                        If (LEqual (PFLV, FDTP))
                                        {
                                            Return (Buffer (One)
                                            {
                                                 0x00                                           
                                            })
                                        }

                                        And (\GR00, 0xFFFDFFFF, \GR00)
                                        Return (Buffer (One)
                                        {
                                             0x0F                                           
                                        })
                                    }
                                    Default
                                    {
                                        Return (Buffer (One)
                                        {
                                             0x00                                           
                                        })
                                    }

                                }
                            }
                            Case (One)
                            {
                                Return (One)
                            }
                            Case (0x02)
                            {
                                \SGPL (0x46, One, One)
                                Return (One)
                            }
                            Case (0x03)
                            {
                                \SGPL (0x46, One, Zero)
                                Sleep (0x0A)
                                Return (One)
                            }
                            Default
                            {
                                Return (Zero)
                            }

                        }
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (\_GPE)
        {
            Method (_L11, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
            {
                If (LEqual (PFLV, FDTP))
                {
                    Return (Zero)
                }

                If (LEqual (\RGPL (0x11, One), One))
                {
                    \SGPP (0x11, One)
                }
                Else
                {
                    \SGPP (0x11, Zero)
                }

                \SGPL (0x46, One, Zero)
                Add (0x80, One, Local1)
                Notify (\_SB.PCI0.SAT0, Local1)
                Return (Zero)
            }
        }
    }
}

