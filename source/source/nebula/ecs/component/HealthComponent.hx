package nebula.ecs.component;

import noor.Exception;

/**
Anything with health. Has current/maximum health.
*/
class HealthComponent
{
    public var currentHealth(default, null):Int = 0;
    public var maximumHealth(default, null):Int = 0;
}