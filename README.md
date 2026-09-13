# Pharmaverse Oncology Workshop

> 目标：用一个可复线的 oncology vertical slice，让统计师在一天内看懂 pharmaverse 的核心组成，并亲自跑通一次 `EDC → SDTM → ADaM → TFL`。

这是一个**培训项目**，不是生产提交包，也不是把真实研究的 SAP 或数据直接自动化。项目刻意把三件事分开：

1. **官方 pharmaverse 示例**：作为包能力、数据结构和编程模式的权威参考；
2. **合成 vendor EDC 路径**：演示如何隔离 source-system 差异；
3. **运行控制**：版本、契约、测试、日志、lineage 和 AI 使用边界。

## 已确认的范围

- 一天课程；
- 实体瘤/RECIST 1.1 语境；
- 合成 vendor EDC export；
- 内部培训原型 + R 迁移方法示范；
- 企业批准的 AI API；
- 不包含 PK；
- 不包含 ARS/ARD；
- 不使用 SAS reference/QC；
- 现场不展开完整 TU/TR 推导，使用 response-focused `RS` vertical slice。

## 课程主线

```text
pharmaverse raw/reference examples
              │
synthetic vendor EDC ── source adapter ──┘
              │
       common workshop contract
              │
        SDTM: DM/EX/AE/RS/DS
              │
        ADaM: ADSL/ADAE/ADRS/ADTTE
              │
        TFL: demographics/AE/BOR/PFS/listing/figure
```

## 重要的质量声明

- 代码中的 teaching derivation 会明确标注为教学规则；
- 对 `sdtm.oak`、`admiral`、`admiralonco`、`metacore`、`metatools`、`xportr`、`rtables` 和 `tern` 的实际用法，以官方 examples 和包文档为准，不复制一个未经验证的“自创 API”；
- synthetic vendor path 用于说明 adapter 和 contract，不暗示它已经通过 CDISC 或监管提交验证；
- 由于不同企业的 R 版本、包镜像和批准版本不同，`renv.lock` 必须在企业批准环境中生成，而不是猜测版本；
- AI 是开发时的辅助工具，不是运行时依赖，也不拥有临床/统计决策权。

## 从哪里开始

1. 阅读 [`docs/teaching-design.md`](docs/teaching-design.md)；
2. 阅读 [`docs/package-map.md`](docs/package-map.md)；
3. 按 [`workshop/README.md`](workshop/README.md) 准备环境；
4. 运行 skill validator：

   ```bash
   python3 scripts/validate_skills.py
   ```

5. 在企业批准 R 环境中按 [`workshop/environment.md`](workshop/environment.md) 安装和锁定依赖；
6. 先跑官方 pharmaverse examples 中选定的脚本，再跑本仓库的 vendor adapter exercise。

## 目录

```text
docs/                         设计原则、包地图、AI 和复线策略
config/                       workshop 决策、数据契约、TFL shell
workshop/                    讲师、学员、环境和练习说明
data-raw/vendor_export/      合成 vendor EDC fixtures
R/                            source contract、adapter、教学 pipeline
skills/                      标准 Agent Skills（SKILL.md + references）
scripts/                     skill 和 fixture 检查
tests/                       不依赖真实数据的契约测试
```

## 当前状态

本次重构先完成一个可审阅的教学设计和代码骨架。实际 R 执行必须在企业批准的 R/container 和 package mirror 中完成；运行日志、`renv.lock`、输出 snapshot 和差异审阅记录应在该环境生成并提交。
