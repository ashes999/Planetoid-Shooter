import massive.munit.TestSuite;

import nebula.ecs.EntityTest;
import nebula.ecs.ContainerTest;
import nebula.ecs.system.DrawSpriteSystemTest;
import nebula.ecs.system.FollowCameraSystemTest;
import nebula.ecs.system.KeyboardInputMovementSystemTest;
import nebula.ecs.system.DrawColourSystemTest;
import nebula.ecs.system.AbstractSystemTest;

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
		add(nebula.ecs.system.DrawSpriteSystemTest);
		add(nebula.ecs.system.FollowCameraSystemTest);
		add(nebula.ecs.system.KeyboardInputMovementSystemTest);
		add(nebula.ecs.system.DrawColourSystemTest);
		add(nebula.ecs.system.AbstractSystemTest);
	}
}
