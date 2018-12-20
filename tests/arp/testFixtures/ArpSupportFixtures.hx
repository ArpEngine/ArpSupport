package arp.testFixtures;

import org.hamcrest.Matcher;
import org.hamcrest.Matchers.*;

class ArpSupportFixtures {

	public static function intFixture():Iterable<Array<Dynamic>> {
		var fixtures:Array<Array<Dynamic>> = [];
		fixtures.push([new DsIntFixture()]);
		return fixtures;
	}

	public static function stringFixture():Iterable<Array<Dynamic>> {
		var fixtures:Array<Array<Dynamic>> = [];
		fixtures.push([new DsStringFixture()]);
		return fixtures;
	}
}

interface IArpSupportFixture<T> {
	function create():IArpSupportFixture<T>;
	var a1(get, never):T;
	var a2(get, never):T;
	var a3(get, never):T;
	var a4(get, never):T;
	var a5(get, never):T;
	var a6(get, never):T;
	var a7(get, never):T;
	var a8(get, never):T;
	var a9(get, never):T;
}

abstract ArpSupportFixtureMatchers<T>(IArpSupportFixture<T>) {

	public var a1(get, never):Matcher<T>;
	private function get_a1():Matcher<T> return equalTo(this.a1);
	public var a2(get, never):Matcher<T>;
	private function get_a2():Matcher<T> return equalTo(this.a2);
	public var a3(get, never):Matcher<T>;
	private function get_a3():Matcher<T> return equalTo(this.a3);
	public var a4(get, never):Matcher<T>;
	private function get_a4():Matcher<T> return equalTo(this.a4);
	public var a5(get, never):Matcher<T>;
	private function get_a5():Matcher<T> return equalTo(this.a5);
	public var a6(get, never):Matcher<T>;
	private function get_a6():Matcher<T> return equalTo(this.a6);
	public var a7(get, never):Matcher<T>;
	private function get_a7():Matcher<T> return equalTo(this.a7);
	public var a8(get, never):Matcher<T>;
	private function get_a8():Matcher<T> return equalTo(this.a8);
	public var a9(get, never):Matcher<T>;
	private function get_a9():Matcher<T> return equalTo(this.a9);

	private function new(fixture:IArpSupportFixture<T>) this = fixture;

	@:from
	public static function fromFixture<T>(fixture:IArpSupportFixture<T>):ArpSupportFixtureMatchers<T> return new ArpSupportFixtureMatchers(fixture);
}

class DsIntFixture implements IArpSupportFixture<Int> {

	public var a1(get, never):Int;
	private function get_a1():Int return 1;
	public var a2(get, never):Int;
	private function get_a2():Int return 2;
	public var a3(get, never):Int;
	private function get_a3():Int return 3;
	public var a4(get, never):Int;
	private function get_a4():Int return 4;
	public var a5(get, never):Int;
	private function get_a5():Int return 5;
	public var a6(get, never):Int;
	private function get_a6():Int return 6;
	public var a7(get, never):Int;
	private function get_a7():Int return 7;
	public var a8(get, never):Int;
	private function get_a8():Int return 8;
	public var a9(get, never):Int;
	private function get_a9():Int return 9;

	public function new() {
	}

	public function create() return this;
}

class DsStringFixture implements IArpSupportFixture<String> {

	public var a1(get, never):String;
	private function get_a1():String return "1";
	public var a2(get, never):String;
	private function get_a2():String return "2";
	public var a3(get, never):String;
	private function get_a3():String return "3";
	public var a4(get, never):String;
	private function get_a4():String return "4";
	public var a5(get, never):String;
	private function get_a5():String return "5";
	public var a6(get, never):String;
	private function get_a6():String return "6";
	public var a7(get, never):String;
	private function get_a7():String return "7";
	public var a8(get, never):String;
	private function get_a8():String return "8";
	public var a9(get, never):String;
	private function get_a9():String return "9";

	public function new() {
	}

	public function create() return this;
}
