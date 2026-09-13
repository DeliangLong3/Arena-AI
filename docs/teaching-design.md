# Teaching design

## 核心学习结果

一天结束时，学员不需要记住每个函数，而需要能回答：

1. pharmaverse 的 raw data、SDTM、ADaM、metadata 和 TFL 工具分别解决什么问题？
2. 一个 vendor EDC 字段如何通过 source contract 进入标准数据？
3. `admiral` 与 `admiralonco` 为什么适合做 ADaM，而不是“自动决定研究规则”的黑盒？
4. 哪些内容是可复用的 R/package 逻辑，哪些内容仍属于 study-specific specification？
5. 如何用 Git、lockfile、pipeline、tests 和 lineage 让 R 结果可复线？
6. AI 如何减少机械操作，而不拥有 clinical/statistical authority？

## Golden path

为避免一天课程被过多 domain 分散，现场只跑一个 response-focused vertical slice：

| Layer | Live scope | Teaching point |
| --- | --- | --- |
| source | vendor `patients`, `exposure`, `adverse_events`, `tumor_assessments`, `disposition` | vendor 差异应被 adapter 隔离 |
| SDTM | DM、EX、AE、RS、DS | domain、controlled terminology、study day、traceability |
| ADaM | ADSL、ADAE、ADRS、ADTTE | population、event/censoring、response、provenance |
| TFL | demographics、TEAE、BOR/ORR、PFS、listing、KM | ADaM 到输出的直接路径；不加入 ARS |

完整 TU/TR/RS algorithm、LB/ADLB、Define-XML、XPT 和 eSub 作为“下一步路线”，不冒充现场交付物。

## 一天安排

| 时间 | 主题 | 学员可见的证据 |
| --- | --- | --- |
| 09:00–09:40 | pharmaverse 生态和 R 转化 | package map、官方 examples、迁移对照 |
| 09:40–10:10 | 项目合同和 vendor 数据 | source contract、fixture profile、拒绝条件 |
| 10:10–11:25 | raw/source → SDTM | DM/AE/RS 的 mapping、检查和 lineage |
| 11:25–12:00 | 受控故障 | schema 错误、缺失 code、重复 key 被阻断 |
| 13:00–14:20 | SDTM → ADaM | ADSL、ADAE、ADRS、ADTTE 规则与测试 |
| 14:20–15:20 | ADaM → TFL | `rtables`/`tern` direct path、listing、PFS figure |
| 15:20–16:00 | 合成 vendor EDC 复跑 | adapter 变化，下游逻辑复用 |
| 16:00–16:35 | AI 辅助和审计 | skill contract、人工 gate、interaction record |
| 16:35–17:00 | clean rerun | manifest、hash、snapshot、复线结果 |

## 课程素材策略

- **官方能力演示**：引用并运行固定 revision 的 `pharmaverse/examples` 中的 ADaM/TLG 示例；
- **企业迁移演示**：在本仓库中运行合成 vendor adapter；
- **不把两者混写**：官方示例用于学习真实包 API，本仓库代码用于展示 source-system contract 和教学控制。

## 成功判定

学员的成功不是“背下所有包名”，而是能独立完成以下路径：

```text
检查环境 → 检查 source contract → 运行 adapter → 检查 SDTM
→ 检查 ADaM → 生成一个 TFL → 查看 lineage → 从 clean state 重跑
```
