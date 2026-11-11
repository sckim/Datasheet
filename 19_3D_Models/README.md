# 19_3D_Models — 부품 3D 모델 라이브러리

제조사·외부에서 받은 **부품 3D 모델**을 한 벌만 보관한다. 다른 프로젝트에서 케이스·기판 3D 조립에 다시 쓰려고 모았다 (2026-11-11 신설, 2mT_PEMF 에서 편입).

## 규칙

- 이름: `<제조사>_<부품번호>.<확장자>` (STEP 우선, 없으면 원본 형식). 제조사별·프로젝트별 하위 폴더는 만들지 않는다.
- 넣는 것: 제조사 공식 모델, 유통사·GrabCAD 등에서 받은 외부 모델, KiCad 로컬 라이브러리용으로 만든 부품 STEP.
- 넣지 않는 것: **프로젝트 전용 조립체**(케이스 전체·기판 STEP·가공을 반영한 변형 모델). 그것은 해당 프로젝트 저장소에 둔다.
- 제조사 CAD 는 **개인 보관용**이다. 제조사 약관에 따라 재배포하지 않는다.
- 파일을 넣거나 뺀 뒤에는 `_ops\` 의 카탈로그 재생성 스크립트를 다시 돌린다(`..\README.md` 참조).

## 목록

| 파일 | 부품 | 출처 | 취득 | 메모 |
|---|---|---|---|---|
| `Neutrik_NAUSBC-5G-FL15.stp` | Neutrik USB-C 5G D형 패널 커넥터 (플라이리드 15 cm) | neutrik.com 제품 페이지 다운로드 | 2026-11-11 | 리드 길이 포함 모델. Ø24 + M3 대각 2개 장착 |
| `Schneider_XB4BS8444.stp` | Schneider Harmony XB4 비상정지 (Ø22, 2NC, 머리 Ø40) | shop.se.com CAD(`XB4BS844n_3D-CAD-Simpl.stp`) | 2026-11-11 | 간략 모델. 판 앞 38.7 mm · 판 뒤 42.8 mm. z=42.8 이 판 앞면, Ø21.7 몸통 3 mm 구간이 판 두께 |
| `Bananenbuchse_4mm.step` / `.jpg` | 4 mm 바나나 소켓 겸 바인딩 포스트 (널링 캡) | AliExpress 구매품(item 1005003950051778) 모델 | 2026-11-11 | 전체 길이 47.9 mm · 캡 최대 Ø13 · 판 단차 Ø12 · 뒤 스터드는 이 모델이 M5 계열(Ø4.9)이나 구매 사양은 M3 — 판 장착 시 확인 |
| `GrabCAD_LCD20x4_HD44780.stp` / `.jpg` | LCD 20×4 HD44780 (PCF8574 I2C 모듈 포함) | GrabCAD `lcd20x4hd44780` | 2026-11-10 | 장착구멍 92.96 × 54.61 mm (Ø3.36), 창 99 × 41 mm |
| `ST_NUCLEO-F411RE.step` | ST NUCLEO-F411RE 보드 | ST 3D 모델 | 2026-11-10 | Nucleo-64 규격이라 F103RB 와 외형 동일 |
| `ZIM26-C14.sldprt` | 3-in-1 C14 AC 인렛 (퓨즈 + 스위치 일체, 스냅인) | CADENAS(SolidWorks 원본) | 2026-11-10 | STEP 으로 변환해 둔 것이 아니다 — SolidWorks 에서 STEP 저장본이 생기면 교체 |
| `Fischer_SK92-100SA_PCBMount_3xM4.step` | Fischer SK 92/100 SA 방열판 100×40×100 | KiCad 로컬 라이브러리용 작성(2026-09-08) | 2026-10 | 구멍은 하단 M4 탭 3개(피치 40) 단순 모델. 프로젝트별 가공은 따로 만든다 |
| `Murata_MEE3SxxxxSC_THT.step` | Murata MEE3S 절연형 DC-DC | KiCad 로컬 라이브러리 | 2026-10 | |
| `Ametherm_SL32_D31mm.step` | Ametherm SL32 인러시 NTC (Ø31 mm) | KiCad 로컬 라이브러리 | 2026-10 | |
| `Songle_SLA-12VDC-SL-C_6pin.step` | Songle SLA-12VDC-SL-C 릴레이 | KiCad 로컬 라이브러리 | 2026-10 | |
| `Stud_M5_x2_RingLug_P25.4mm.step` | M5 스터드 2개 + 링러그 (피치 25.4 mm) | KiCad 로컬 라이브러리 | 2026-10 | |
| `Stud_M4_PCB-147D.step` / `.wrl` | M4 PCB 스터드 | KiCad Allegro 라이브러리 | 2026-10 | |

쓰인 프로젝트: 2mT_PEMF (`Hardware\Enclosure`, `Hardware\Schematics\PEMF_v1.0\*.3dshapes`).
