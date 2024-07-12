Welcome to my first godot project. The name of the game is "Area Zero". The game will be in 2D and the goal is to make 100 levels,
bosses every 10 levels and the respective final boss.
It is an ambitious project in which I am going to go little by little.
I will comment on all the steps I am doing. It should be said that I have never used godot except for a course in which I was taught the basics, which I am applying and expanding my knowledge.

Getting started:
**Character creation**.

We've created our main character, which is going to be a turtle. It will be called Galapagos, which, as we advance in the game, will be stronger and will learn new skills.

![terapagos quieto](https://github.com/CristianRMN/Zero-Area/assets/172594866/0e445a6b-3b82-4f09-9b0b-11385372af9f)


**First advances in movements**.

This is the script to make the character move sideways and jump. With the spritesFrames we have managed to get it to acquire that kind of movement when walking from one side to the other.

![scriptMovimientoTerapagos1](https://github.com/CristianRMN/Zero-Area/assets/172594866/065ea9cf-e12c-4d6e-aec6-46721fcca020)
![scriptMovimientoTerapagos2](https://github.com/CristianRMN/Zero-Area/assets/172594866/6561145d-b53d-4775-ac53-cd713739d5c6)

**We're going to add the rest of our protagonist's initial moves**
1. We modify the script and add new action buttons to the project
   ![scriptMovimientoTerapagos3](https://github.com/CristianRMN/Zero-Area/assets/172594866/2691f35f-962d-4451-99ea-9654c3106738) 
   ![scriptMovimientoTerapagos4](https://github.com/CristianRMN/Zero-Area/assets/172594866/31d3e50c-35f9-4d10-afd8-a1de3fade28a)
   ![scriptMovimientoTerapagos5](https://github.com/CristianRMN/Zero-Area/assets/172594866/50a4daa6-ada4-4cd6-b050-e90cf6ed8b9d)

2. As you can see, we have added new spritesFrames, which we show in the screenshot below and we had to update the script
   ![scriptMovimientoTerapagos6](https://github.com/CristianRMN/Zero-Area/assets/172594866/cd9c3b78-136a-46bb-9530-0cbda78f21a1)

The character's movements are done, here we show them better:

1. Walk
![terapagos caminando a la derecha](https://github.com/CristianRMN/Zero-Area/assets/172594866/b20071c0-c655-4150-86d5-c88303e4c9ee)

2. Protect yourself
![terapagos protegiendose a la derecha](https://github.com/CristianRMN/Zero-Area/assets/172594866/119f093e-79a4-4141-9bfc-91af325133e1)

3. Feed
![terapagos alimentandose mirando a la derecha](https://github.com/CristianRMN/Zero-Area/assets/172594866/e6f786d5-214c-4773-b9c8-240e5fb35a6b)

4. Attack
![terapagos atacando mirando a la derecha](https://github.com/CristianRMN/Zero-Area/assets/172594866/de40a322-cb9d-4814-9139-808125af75ae)

5. Sleep
![terapagos durmiendo a la derecha](https://github.com/CristianRMN/Zero-Area/assets/172594866/8b842c31-5a58-40c2-ad91-f890859a5a13)

More will be added later as you defeat the enemies in the game.

***Adding Protagonist Attack***
We proceed to add the first attack of our protagonist. Later, as he defeats enemies and bosses, he will gain new abilities, but this will be his initial attack.
![bolaDeFuegoQuieta1](https://github.com/CristianRMN/Zero-Area/assets/172594866/4732d3b4-50db-4ab4-8f40-ea179d83b095)

A fairly simple fireball that has an animation
![bolaDeFuegoQuieta1](https://github.com/CristianRMN/Zero-Area/assets/172594866/85cc0d13-e649-4959-83e6-87f6cd37fa0a)
![bolaDeFuegoMovimientoDerecha](https://github.com/CristianRMN/Zero-Area/assets/172594866/92b63da7-3326-48eb-92f5-2b8b7fbe161c)
![bolaDeFuegoMovimientoDerecha2](https://github.com/CristianRMN/Zero-Area/assets/172594866/79813c93-3a00-4837-ab2d-2264b30c4076)

remember to add the animations in the animatedSprite and put a collisionShape on it so that it impacts something


Here's the initial fireball script
![boladefuegoscript1](https://github.com/CristianRMN/Zero-Area/assets/172594866/bd8aa9fc-8487-475b-be6d-8123c1121857)


Now let's integrate this ball into the protagonist scene
1. Let's modify the fireball script
![boladefuegoscript2](https://github.com/CristianRMN/Zero-Area/assets/172594866/95c2c401-2f00-4d2b-bba4-908318b55792)

2. The setup function will help us a lot when it comes to establishing the direction of the fireball, so that it is seen that it moves to the right or left and rotates on both sides
3. Now it's time to modify the protagonist's script again to add the fireball scene
   ![boladefuegoscript3](https://github.com/CristianRMN/Zero-Area/assets/172594866/2bbef6bb-521d-4459-8e35-6237d55ead45)

   ![boladefuegoscript4](https://github.com/CristianRMN/Zero-Area/assets/172594866/45c97202-3f83-4e92-8685-f8936298386d)

   ![boladefuegoscript5](https://github.com/CristianRMN/Zero-Area/assets/172594866/cc03dcda-0631-4ead-b490-c585f46b127e)

4. The most important modifications are the exported variable which we have called fireball_scene. We have exported it to be able to add the scene from the editor
5. In the action of attacking, we call the function of firing the fireballç
6. And in the function of shooting the fireball, we set the speed and direction of the ball
7. The result would look something like this:

![boladefuegoscript6](https://github.com/CristianRMN/Zero-Area/assets/172594866/e30f8746-a617-4008-bf53-08185c52a6a7)

![boladefuegoscript7](https://github.com/CristianRMN/Zero-Area/assets/172594866/93f30850-0408-41c4-9944-b33d9e0371b7)

***Protagonist Attacks Finished (For Now)***
The attacks are finished, it is true that there are still things to correct, small fixes to make, but for now we will leave it at that, at the expense of adding more set of moves as we advance in the game. Now let's focus on 3 fundamental things:

1. Development of the 100 levels
2. Make bosses and enemies
3. Make the game story

***Development of the first 10 levels***
**Collision Bug Updates and Other Bugs**
It took me a while to fix the collision bug, since I do this on vacation and I'm not with it all the time.
We've redone the character script from 0, animations from 0, and so on. 
![nuevoScriptPersonaje](https://github.com/CristianRMN/Zero-Area/assets/172594866/34a7b59c-3d0f-4ee8-820d-b4a486c2bd5b)


First scene of the 1-10 world:
![mundo1-10parte1](https://github.com/CristianRMN/Zero-Area/assets/172594866/6156fbdd-1cd0-4249-b968-650c5fa443e3)

This is the first scene in the world 1 of 10. I said first since from level 1 to 9, there will be 5 scenes. 
Level 10 will have 10 cutscenes and the final boss and other things.

**Level 1:**
1. first scene:
   ![mundo1-10parte1](https://github.com/CristianRMN/Zero-Area/assets/172594866/6156fbdd-1cd0-4249-b968-650c5fa443e3)

   This first scene has nothing to it, since it is an introduction.
   It only has a field, a simple jump and a sign that when you read it indicates some instructions.

   This would be scene 1 of level 5 finished. In this level we have a total of 9 scenes I think,
    but to pass the level, you just have to access 5 of them alone.
   ![escena1](https://github.com/user-attachments/assets/8b0d18fd-ca21-4539-9a64-378dd78468c2)

   All the functionalities are included here, at the expense of details, such as maintaining the value
   of the life bar in the change of scene and improving the design that is not what I am best at doing.

2. Second Scene:
   ![escena2](https://github.com/user-attachments/assets/428bf8ad-8a6c-462b-a580-ba908ea38fde)

   Here we have the second scene, quite simple, a few jumps and little else

3. Third Scene:
   ![escena3](https://github.com/user-attachments/assets/53b79fdc-c9e2-4474-a95b-b4e69031f54f)

   In this third scene we already start doing more things. Like putting floating platforms,
    access to other scenes, like in that cabin that you can see, respawns...





   
