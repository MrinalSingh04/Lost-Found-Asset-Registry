# 🏷✨ Lost & Found Asset Registry 🗝️

## **🔍 What**

The **Lost & Found Asset Registry** is a blockchain-based system for registering valuable items as **NFT proof-of-ownership** 🪪 and attaching a bounty 💰 for their recovery if lost.
  
Each registered asset is minted as a unique NFT within the contract, storing:

- 📜 **Description** of the item 
- 💵 **Bounty amount** in ETH
- 📍 **Lost/Found status**
- 🕵️ **Finder address** (once reported) 

If a finder returns the item, the owner can confirm ✅ and release the bounty trustlessly.

---

## **💡 Why**

Traditional lost & found systems are often slow 🐢, centralized 🏢, and prone to disputes ⚠️. This smart contract introduces:

- 🛡 **Proof of Ownership** — NFTs serve as tamper-proof certificates of item ownership.
- 🎯 **Incentivized Recovery** — A bounty encourages honest returns.
- 🔒 **Trustless Escrow** — Funds are locked until confirmed by the rightful owner.
- 🌍 **Global Access** — Anyone can register or return items without relying on a central authority.

---

## **⚙️ How It Works**

1. **📌 Register an Item**

   - Call `registerItem(description)`
   - Send ETH as a bounty 💎
   - A unique NFT is minted to your wallet 🪙

2. **🛎 Report Item Found**

   - Finder calls `reportFound(itemId)`
   - Contract logs finder’s address 🗂

3. **🤝 Confirm Return**

   - Owner calls `confirmReturn(itemId)`
   - Bounty is automatically sent to finder 💸

---

## **🧩 Core Functions**

- `registerItem(string description)` — Mint an NFT and attach a bounty.
- `reportFound(uint256 itemId)` — Finder reports they located the item.
- `confirmReturn(uint256 itemId)` — Owner confirms return and releases bounty.

---

## **📢 Events**

- `ItemRegistered(itemId, owner, description, bounty)` — New asset registered.
- `ItemFound(itemId, finder)` — Finder reports an item.
- `BountyClaimed(itemId, finder, amount)` — Finder claims bounty.

---

## **🔐 Security Notes**

- Only the **owner of the NFT** can confirm a return.
- Bounty is stored in contract until return confirmation.
- No third-party mediation — relies on trust in the confirmation step.

---

## **📌 Example Use Cases**

- 🚲 Lost bicycles
- 💻 Electronics
- 💍 Jewelry
- 🐶 Pet recovery incentives

---

## **🛠 Deployment**

1. Compile with Solidity `^0.8.25`
2. Deploy to desired blockchain 🌐
3. Interact via Remix, Hardhat, or a dApp frontend 💻

---

## **📜 License**

MIT License — Open for personal and commercial use ✅
