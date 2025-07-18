# ReferralSystem + AccountManager – Smart Contract Suite (Developed by Lorebit Studio)

This repository contains a suite of **on-chain referral system smart contracts** developed by **Lorebit Studio** to demonstrate a transparent, configurable affiliate/referral system deployed on **Base Sepolia**.

---

## 🎮 Project Overview

This project showcases a simple yet robust referral system for tracking referrals, paying fixed commissions, and allowing referrers to claim their rewards in ETH.

It includes contracts for:
- Tracking referees and their referrers.
- Crediting fixed commissions per referral.
- Allowing referrers to claim accrued commissions securely.
- Managing which accounts can register users and issue referrals.

---

## 👨‍💻 Lorebit Studio's Role

Lorebit Studio developed all smart contracts, deployment scripts, verification scripts, and testing utilities for this showcase:

- **ReferralSystem:** Core contract managing referrer/referee mapping, commission accrual, payouts, and funding.
- **AccountManager:** Frontend contract for user registration that interacts with ReferralSystem.
- Deployment & verification scripts.
- Test scripts simulating full lifecycle: funding, registering, earning, and claiming.

---

## 🔨 Contracts Included

| Contract             | Description |
|-----------------------|-------------|
| **ReferralSystem.sol** | Core contract tracking referrals, managing commissions, allowing claims & funding. |
| **AccountManager.sol** | Handles user registration and interacts with ReferralSystem for recording referrals. |

---

## 🧠 Key Features

✅ Transparent referral tracking on-chain.  
✅ Fixed commission amount per referral.  
✅ Supports only authorized registration managers.  
✅ ETH-based funding & payouts with safety checks.  
✅ Fully verified on Base Sepolia block explorer.  
✅ Uses OpenZeppelin security primitives (Ownable, AccessControl, ReentrancyGuard).

---

## 🚀 Use Cases

Although this implementation is demonstrated with simple account registration, the **ReferralSystem + AccountManager** architecture is flexible and can be integrated into various on-chain and hybrid systems, such as:

- 📈 Token sales & ICOs — reward users who refer others to buy tokens.
- 🛒 NFT marketplaces — reward referrers when someone they invite purchases an NFT.
- 🎮 Web3 games — reward players for bringing in new players or guild members.
- 🏦 DeFi platforms — reward users who onboard liquidity providers or stakers.
- 👨‍🏫 Learning platforms — reward learners who refer classmates or colleagues.
- 🧩 Any dApp — where incentivized growth via referrals makes sense.

You can adapt the commission mechanism, referral tracking, and claiming logic to fit specific business needs — supporting ERC20, ERC721, ERC1155, or even off-chain actions that are validated on-chain.

---

## 🌐 Deployments

### 🧪 Testnet – Base Sepolia

**Contracts Owner:**  
`0xB94503C6a717BDD677ad9dAB7B450AF86d3Aa3F5`

| Contract           | Address |
|---------------------|---------|
| **ReferralSystem**  | [0xD12454843f6662BD1Cd27fB2DEA526f911c133a8](https://sepolia.basescan.org/address/0xD12454843f6662BD1Cd27fB2DEA526f911c133a8) |
| **AccountManager**  | [0x22430042749Bb0eb036d1e009E60EcE8fc9353aE](https://sepolia.basescan.org/address/0x22430042749Bb0eb036d1e009E60EcE8fc9353aE) |

---

## 🏗️ Built For

**Lorebit Studio Portfolio Project**  
A demonstration of decentralized referral & commission mechanics on an EVM L2 testnet.

---

## 🧑‍💻 Developed By

**Lorebit Studio**  
Smart Contract Development • Tokenomics Design • Fullstack Blockchain Engineering

🌐 [lorebitstudio.com](https://lorebitstudio.com)  
✉️ contact@lorebitstudio.com

---

## 📄 License

This repository is licensed under the **MIT License**.

---

## ⭐ Usage

This repository is intended for portfolio and showcase purposes.  
If you are interested in hiring **Lorebit Studio** or using these contracts commercially, please get in touch!

---