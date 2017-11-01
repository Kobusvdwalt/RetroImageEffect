using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class RetroImageEffect : MonoBehaviour {

	public Color color;
	public float steps = 5f;
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	Material m;
	void OnRenderImage (RenderTexture inputTex, RenderTexture outputTex) {
		if (m == null) {
			m = new Material (Shader.Find ("Custom/Retro"));
		}

		m.SetColor ("_Color", color);
		m.SetFloat ("_ColorSteps", steps);
		Graphics.Blit (inputTex, outputTex, m);
	}
}
