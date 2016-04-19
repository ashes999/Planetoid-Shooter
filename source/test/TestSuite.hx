import massive.munit.TestSuite;

import nebula.ecs.EntityTest;
import nebula.ecs.ContainerTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(nebula.ecs.EntityTest);
		add(nebula.ecs.ContainerTest);
	}
}
