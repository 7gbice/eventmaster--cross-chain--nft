import { expect } from "chai";
import { ethers } from "hardhat";
import { EventMaster } from "../typechain-types";

describe("EventMaster", function () {
  // We define a fixture to reuse the same setup in every test.

  let EventMaster: EventMaster;
  before(async () => {
    const [owner] = await ethers.getSigners();
    const EventMasterFactory = await ethers.getContractFactory("EventMaster");
    EventMaster = (await EventMasterFactory.deploy(owner.address)) as EventMaster;
    await EventMaster.deployed();
  });

  describe("Deployment", function () {
    it("Should have the right message on deploy", async function () {
      expect(await EventMaster.greeting()).to.equal("Building Unstoppable Apps!!!");
    });

    it("Should allow setting a new message", async function () {
      const newGreeting = "Learn Scaffold-ETH 2! :)";

      await EventMaster.setGreeting(newGreeting);
      expect(await EventMaster.greeting()).to.equal(newGreeting);
    });
  });
});
