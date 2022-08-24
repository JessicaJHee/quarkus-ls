package org.acme.qute;

import java.math.BigDecimal;

public class Item {

    public final BigDecimal price;
    public final String name;
    public final Boolean status;
    public final String person;
    public final MachineStatus machineStatus;

    public Item(BigDecimal price, String name, Boolean status, String person, MachineStatus machineStatus) {
        this.price = price;
        this.name = name;
        this.status = status;
        this.person = person;
        this.machineStatus = machineStatus;
    }

}