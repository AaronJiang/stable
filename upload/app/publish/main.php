<?php
/*
+--------------------------------------------------------------------------
|   Anwsion [#RELEASE_VERSION#]
|   ========================================
|   by Anwsion dev team
|   (c) 2011 - 2012 Anwsion Software
|   http://www.anwsion.com
|   ========================================
|   Support: zhengqiang@gmail.com
|   
+---------------------------------------------------------------------------
*/


if (!defined('IN_ANWSION'))
{
	die;
}

class main extends AWS_CONTROLLER
{
	public function get_access_rule()
	{
		$rule_action['rule_type'] = 'white'; //黑名单,黑名单中的检查  'white'白名单,白名单以外的检查
		$rule_action['actions'] = array();
		return $rule_action;
	}

	public function setup()
	{
		$this->crumb('信息发布', '/publish/');
	}

	public function index_action()
	{
		if ($_GET['question_id'])
		{
			if (!$question_info = $this->model('question')->get_question_info_by_id(intval($_GET['question_id'])))
			{
				H::redirect_msg("指定问题不存在", '/question/' . $_GET['question_id']);
			}
			
			if (!$this->user_info['permission']['is_administortar'] AND !$this->user_info['permission']['is_moderator'] AND !$this->user_info['permission']['edit_question'])
			{
				if ($question_info['published_uid'] != $this->user_id)
				{
					H::redirect_msg("你没有权限编辑这个问题", '/question/' . $_GET['question_id']);
				}
			}
			
			TPL::assign('question_info', $question_info);
		}
		else if (!$this->user_info['permission']['publish_question'] AND !$this->user_info['permission']['is_administortar'] AND !$this->user_info['permission']['is_moderator'])
		{
			H::redirect_msg('你所在用户组没有权限发布问题');
		}
		else if ($this->is_post())
		{
			TPL::assign('question_info', array(
				'question_content' => $_POST['question_content'],
				'question_detail' => $_POST['question_detail']
			));
			
			$question_info['category_id'] = $_POST['category_id'];
		}
		
		if ($this->user_info['integral'] <= 0 AND get_setting('integral_system_enabled') == 'Y' AND !$_GET['question_id'])
		{
			H::redirect_msg('你的剩余积分已经不足以进行此操作');
		}
		
		TPL::assign('attach_access_key', md5($this->user_id . time()));
		
		if (!$question_info['category_id'] AND $_GET['category_id'])
		{
			$question_info['category_id'] = $_GET['category_id'];
		}
		
		if (get_setting('category_enable') == 'Y')
		{
			TPL::assign('question_category_list', $this->model('system')->build_category_html('question', 0, $question_info['category_id']));
		}
		
		if ($modify_reason = $this->model('question')->get_modify_reason())
		{
			TPL::assign('modify_reason', $modify_reason);
		}
		
		TPL::assign('human_valid', human_valid('question_valid_hour'));
		
		TPL::import_css('css/main.css');
		TPL::import_js('js/publish.js');
		
		if (get_setting('advanced_editor_enable') == 'Y')
		{
			TPL::import_js('js/markItUp.js');
		}
		
		TPL::output('publish/index');
	}
	
	public function wait_approval_action()
	{
		if ($_GET['question_id'])
		{
			if ($_GET['is_mobile'])
			{
				$url = '/mobile/question/' . $_GET['question_id'];
			}
			else
			{
				$url = '/question/' . $_GET['question_id'];
			}
		}
		else
		{
			$url = '/';
		}
		
		H::redirect_msg('发布成功, 请等待管理员审核...', $url);
	}
}