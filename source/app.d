import kratos;

import std.math;

import kratos.input;
import kratos.component.physics;
import kratos.component.meshrenderer;
import kratos.component.time;

import kratos.ecs.entity;
import kratos.ecs.component : optional, ignore, dependency;
import kratos.graphics.shadervariable : UniformRef;

import kgl3n.vector;

public class Flashy : Component
{
	@optional:
	private @dependency MeshRenderer meshRenderer;
	private @dependency Time time;

	float speed = 1;
	vec3 color = vec3(1, 0, 0);
	float offset = 0;
	private ShaderVars shaderVars;

	public void initialize()
	{
		shaderVars = meshRenderer.mesh.renderState.shader.getRefs!ShaderVars;
	}

	public void frameUpdate()
	{
		shaderVars.color = color * (sin((time.total + offset) * speed) * 0.5 + 0.5);
	}

	private static struct ShaderVars
	{
		UniformRef!vec3 color;
	}
}

public class Thruster : Component
{
	private @dependency RigidBody rigidBody;
	public vec3 force;
	
	void frameUpdate()
	{
		if(keyboard["Space"].pressed)
		{
			rigidBody.addForce(force);
		}
	}
}

static this()
{
	registerComponent!Flashy;
	registerComponent!Thruster;
}