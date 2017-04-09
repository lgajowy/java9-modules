package com.lukasz.main;

import com.lukasz.clock.SpeakingClock;

public class Main {

    public static void main (String[] args) {
        SpeakingClock clock = new SpeakingClock();

        clock.tellTheTime();
    }
}
